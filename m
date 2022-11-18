Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E062F600
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 14:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbiKRN30 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 08:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbiKRN3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 08:29:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820838C4A0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 05:29:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso3058441otb.2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cC2JN4ZUsjuEwnjnpajcpS5m9KPPu/uO4FGcPfQVcS4=;
        b=jUN18wTmj+1ZYiBLq0ATj/xOBRgTuQJR9jqDHN+c8l+d8YniEEXDh7dFTMb2sHXMDV
         SmTPFJhZFAGJ0xjc94bqvehQQBz2lJO1+mlg2LQkKAYJvyKPDNgOQOuuVom52Ccy0072
         PPTJ2vlkRZeGK/xUueiFbHK9B5VMpWVW1yHvkl43psWyLwjs7fy4tYqlZTEOVMSQAFXN
         o6p/hGINRd7mCC/m1wirC0Heq0GKSrk86iv5x3X9OQOzF5tlK25vHXKxvMsDKgI8xbAE
         t6su0SIVH2uKqE7n1RcGMwqhYmYGR6ys6AwqiID3LAChtDtPnJyTqyQqYBpqFyhT0Vqb
         5HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC2JN4ZUsjuEwnjnpajcpS5m9KPPu/uO4FGcPfQVcS4=;
        b=YXR5K58C0t3bwSzsASRuSkScdEDLMQCM/lprVlSAgg6aO39wiANBsSAv47LowPArji
         PJhtalbFZ3JDAwi4DcOJEC8PSr/lexKf4fTJEGJhM84FpDFD0kf4vbnX+kG/9gwKL//g
         UXgRG5BxCFBn8jJntJByN/5hSHl/tA6rxicMSoPVmawZij2TJxSp1fXbshx+mmavD6/r
         YzpuOeh1oCQTXTI2HeOazSY0ceFN6rQ/f8QmgpKSH4fu0ITqibyNADRks9kru5CNQaMx
         TKWT72hRIfuFWij0IXP1IfalbuNkwW9Mj7VCS2bLWtkhHeo62tMh5VPLHfCCDgV8uiDM
         bIzA==
X-Gm-Message-State: ANoB5pmThMNAxqW6Vgf3Ors1GKdb45MgV7fs5lONNGLV3OGSAqKylnzo
        L4Iu4CbyJpYOTGAT7XsmGEXGkCuzFkS+veOXRF/29A==
X-Google-Smtp-Source: AA0mqf5K0ISjTVWz7ORFlgRvVl+wnmbgFAM22X4Xo5cff4bPY2eHs65n+6z5Dd5IjlVNyeMYLAxeOJS1SBuijdpzp0A=
X-Received: by 2002:a05:6830:1b62:b0:66c:7982:2d45 with SMTP id
 d2-20020a0568301b6200b0066c79822d45mr3794575ote.123.1668778144575; Fri, 18
 Nov 2022 05:29:04 -0800 (PST)
MIME-Version: 1.0
References: <00000000000060c7e305edbd296a@google.com>
In-Reply-To: <00000000000060c7e305edbd296a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 18 Nov 2022 14:28:53 +0100
Message-ID: <CACT4Y+a=HbyJE3A_SnKm3Be-kcQytxXXF89gZ_cN1gwoAW-Zgw@mail.gmail.com>
Subject: Re: [syzbot] unregister_netdevice: waiting for DEV to become free (7)
To:     syzbot <syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, chenzhongjin@huawei.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 18 Nov 2022 at 12:39, syzbot
<syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9c8774e629a1 net: eql: Use kzalloc instead of kmalloc/memset
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bf6cc8f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9eb259db6b1893cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e70d01ee8985ae62a3b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d592f00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1193ae64f00000
>
> Bisection is inconclusive: the issue happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167c33a2f00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=157c33a2f00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=117c33a2f00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5e70d01ee8985ae62a3b@syzkaller.appspotmail.com
>
> iwpm_register_pid: Unable to send a nlmsg (client = 2)
> infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98
> unregister_netdevice: waiting for vlan0 to become free. Usage count = 2

+RDMA maintainers

There are 4 reproducers and all contain:

r0 = socket$nl_rdma(0x10, 0x3, 0x14)
sendmsg$RDMA_NLDEV_CMD_NEWLINK(...)

Also the preceding print looks related (a bug in the error handling
path there?):

infiniband syj1: RDMA CMA: cma_listen_on_dev, error -98

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
