Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10842377144
	for <lists+linux-rdma@lfdr.de>; Sat,  8 May 2021 12:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhEHKmj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 May 2021 06:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhEHKmi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 May 2021 06:42:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BB61761075
        for <linux-rdma@vger.kernel.org>; Sat,  8 May 2021 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620470497;
        bh=nSgtjPiY4rYbYE2K+loqAUNqeGVDfx8jscbS40LFOaM=;
        h=From:To:Subject:Date:From;
        b=TE4qDBJxf4uqxxz2wnAPUwLgRKn9vL19bm+olgON9OI6bu6pPMsgZQt3ugEsXICv+
         dQyXui/Abx5LNCAiAqrOuoyAUNqTyfcFaKL4gjPgLPR6rIHGcwgYhqz4kFNIW39oaJ
         z2uleseUiyOTfDoHqmNw307VyBB/rYsTs8+4Xb187eWffD/XpXS1sYyARPewmIX3+O
         L6JWv7wW4KtmMKfcwD5FlEpgUkhAU+PadEQ1Z7w8tk+HEg1ZxZopfuW/aOSpCH38Ux
         qPx6o4WQhMcP6pSRE9BOKUqy4wn/7Frxh72V7hkXQ+4WpLwX6GzwFLd7wocfnhwjNG
         E6M0IKh5kr0gQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id AF2D3611B0; Sat,  8 May 2021 10:41:37 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-rdma@vger.kernel.org
Subject: [Bug 212991] New: A possible divide by zero in calc_sq_size
Date:   Sat, 08 May 2021 10:41:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yguoaz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-212991-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212991

            Bug ID: 212991
           Summary: A possible divide by zero in calc_sq_size
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.12.2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: yguoaz@gmail.com
        Regression: No

In the file drivers/infiniband/hw/mlx5/qp.c, the function calc_sq_size has =
the
following code(link to code location:
https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/mlx5/qp=
.c#L510):

static int calc_sq_size(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *at=
tr,
                        struct mlx5_ib_qp *qp) {
   ...
   wqe_size =3D calc_send_wqe(attr);
   ...
   qp->sq.max_post =3D wq_size / wqe_size;
}


static int calc_send_wqe(struct ib_qp_init_attr *attr)
{
        int inl_size =3D 0;
        int size;

        size =3D sq_overhead(attr);
        if (size < 0)
                return size;

        if (attr->cap.max_inline_data) {
                inl_size =3D size + sizeof(struct mlx5_wqe_inline_seg) +
                        attr->cap.max_inline_data;
        }

        size +=3D attr->cap.max_send_sge * sizeof(struct mlx5_wqe_data_seg);
        if (attr->create_flags & IB_QP_CREATE_INTEGRITY_EN &&
            ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB) <
MLX5_SIG_WQE_SIZE)
                return MLX5_SIG_WQE_SIZE;
        else
                return ALIGN(max_t(int, inl_size, size), MLX5_SEND_WQE_BB);
}

The function calc_send_wqe may return 0 (when attr->qp_type =3D=3D IB_QPT_X=
RC_TGT
&& attr->cap.max_send_sge =3D=3D 0), leading to a possible divide by zero p=
roblem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
