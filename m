Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1311C70D130
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjEWC0H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 22:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEWC0G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 22:26:06 -0400
X-Greylist: delayed 85905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 19:26:02 PDT
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [IPv6:2001:41d0:203:375::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F8CA
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 19:26:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------GFfthMi5biGdyduudWrWSocw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684808760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTp1df867SFJXxt8IIrlaAxbSGmv+ncI2619R+e48qY=;
        b=pCtEX+HUv0p8zw0D/4QLs5MPjgjOX7COq5yVCNmOZ+QOyAzvWD5DPN4EMDvqJxeMqbrUhq
        xLdrolGrolE0PIQEopduFKSy6sEQx8zouRh7DueS8DdFzejqDH5FSBZCo2qR13bEKidGZF
        vISxA3q4WHy+p0du4Qls43zpJrjqHWI=
Message-ID: <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
Date:   Tue, 23 May 2023 10:25:56 +0800
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
Content-Language: en-US
To:     syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com
References: <000000000000a589d005fc52ee2d@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <000000000000a589d005fc52ee2d@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a multi-part message in MIME format.
--------------GFfthMi5biGdyduudWrWSocw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/23/23 10:13, syzbot wrote:
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file drivers/infiniband/sw/rxe/rxe_qp.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         56518a60 RDMA/hns: Modify the value of long message lo..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
> dashboard link: https://syzkaller.appspot.com/bug?extid=eba589d8f49c73d356da
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=132bea5a280000
>

Sorry, let me attach the temp patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git 
for-rc
--------------GFfthMi5biGdyduudWrWSocw
Content-Type: text/x-patch; charset=UTF-8; name="temp-rxe.patch"
Content-Disposition: attachment; filename="temp-rxe.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jCmluZGV4IDYxYTJlYjc3ZDk5OS4uMTdl
ZDQxMzA5NzU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9x
cC5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMKQEAgLTc1OCwx
OSArNzU4LDIxIEBAIHN0YXRpYyB2b2lkIHJ4ZV9xcF9kb19jbGVhbnVwKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKIAkJZGVsX3RpbWVyX3N5bmMoJnFwLT5ybnJfbmFrX3RpbWVyKTsK
IAl9CiAKLQlpZiAocXAtPnJlc3AudGFzay5mdW5jKQorCS8qIGZsdXNoIG91dCBhbnkgcmVj
ZWl2ZSB3cidzIG9yIHBlbmRpbmcgcmVxdWVzdHMgKi8KKwlpZiAocXAtPnJlc3AudGFzay5m
dW5jKSB7CiAJCXJ4ZV9jbGVhbnVwX3Rhc2soJnFwLT5yZXNwLnRhc2spOworCQlyeGVfcmVz
cG9uZGVyKHFwKTsKKwl9CiAKLQlpZiAocXAtPnJlcS50YXNrLmZ1bmMpCisJaWYgKHFwLT5y
ZXEudGFzay5mdW5jKSB7CiAJCXJ4ZV9jbGVhbnVwX3Rhc2soJnFwLT5yZXEudGFzayk7CisJ
CXJ4ZV9yZXF1ZXN0ZXIocXApOworCX0KIAotCWlmIChxcC0+Y29tcC50YXNrLmZ1bmMpCisJ
aWYgKHFwLT5jb21wLnRhc2suZnVuYykgewogCQlyeGVfY2xlYW51cF90YXNrKCZxcC0+Y29t
cC50YXNrKTsKLQotCS8qIGZsdXNoIG91dCBhbnkgcmVjZWl2ZSB3cidzIG9yIHBlbmRpbmcg
cmVxdWVzdHMgKi8KLQlyeGVfcmVxdWVzdGVyKHFwKTsKLQlyeGVfY29tcGxldGVyKHFwKTsK
LQlyeGVfcmVzcG9uZGVyKHFwKTsKKwkJcnhlX2NvbXBsZXRlcihxcCk7CisJfQogCiAJaWYg
KHFwLT5zcS5xdWV1ZSkKIAkJcnhlX3F1ZXVlX2NsZWFudXAocXAtPnNxLnF1ZXVlKTsK

--------------GFfthMi5biGdyduudWrWSocw--
