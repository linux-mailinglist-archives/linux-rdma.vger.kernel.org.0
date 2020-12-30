Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77E2E7D05
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 23:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL3WvY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 30 Dec 2020 17:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgL3WvY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 17:51:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id ADD9E2072E
        for <linux-rdma@vger.kernel.org>; Wed, 30 Dec 2020 22:50:43 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A39C28672F; Wed, 30 Dec 2020 22:50:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 210973] New: info leaks in all kernel versions including
 android
Date:   Wed, 30 Dec 2020 22:50:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: fxast243@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-210973-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210973

            Bug ID: 210973
           Summary: info leaks in all kernel versions including android
           Product: Drivers
           Version: 2.5
    Kernel Version: latest
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: fxast243@gmail.com
        Regression: No

While I audit android kernel source code , I noticed that there is an
Uninitialized data which could lead to info leak in ib_uverbs_create_ah
function. I download the source code from here 
https://android.googlesource.com/kernel/common. Also it exists in the
linux-masters

https://github.com/torvalds/linux/blob/master/drivers/infiniband/core/uverbs_cmd.c#L2408


# BUG
resp.ah_handle = uobj->id;
return uverbs_response(attrs, &resp, sizeof(resp));


# 1
static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
{
        struct ib_uverbs_create_ah       cmd;
        struct ib_uverbs_create_ah_resp  resp; <== point to ah_handle and
driver_data
        struct ib_uobject               *uobj;
        struct ib_pd                    *pd;
        struct ib_ah                    *ah;
        struct rdma_ah_attr             attr = {};
        int ret;
        struct ib_device *ib_dev;

        ret = uverbs_request(attrs, &cmd, sizeof(cmd));
        if (ret)
                ret

..etc



        ah->uobject  = uobj;
        uobj->user_handle = cmd.user_handle;
        uobj->object = ah;
        uobj_put_obj_read(pd);
        uobj_finalize_uobj_create(uobj, attrs);

        resp.ah_handle = uobj->id; <==
      //  __u32 driver_data[0];  <== ??? Uninitialized data.
        return uverbs_response(attrs, &resp, sizeof(resp)); <== memoey leaks



//include/uapi/rdma/ib_user_verbs.h


struct ib_uverbs_create_ah_resp {
        __u32 ah_handle;
        __u32 driver_data[0];
};



static int uverbs_response(struct uverbs_attr_bundle *attrs, const void *resp,
                           size_t resp_len)
{
        int ret;

        if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CORE_OUT))
                return uverbs_copy_to_struct_or_zero(
                        attrs, UVERBS_ATTR_CORE_OUT, resp, resp_len);

        if (copy_to_user(attrs->ucore.outbuf, resp,
                         min(attrs->ucore.outlen, resp_len))) <== copy data to
userspace
                return -EFAULT;

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
