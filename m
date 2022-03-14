Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D24D8646
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiCNN7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCNN7K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 09:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5589217E23
        for <linux-rdma@vger.kernel.org>; Mon, 14 Mar 2022 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647266278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDirMt6DUmLUozphOEbENIKMtwE4Z7punVtOAUrkDBM=;
        b=ADQ+d7fPWfPFPUgajX2z4db/BX++C2kTSjc55ZFoVJsKOGe/n4oMKXmqq81fqnR9YVFJcB
        E6S4HqncEafK0/qsZQ5Nc/VqJfQOgr5uliiF85nklDgDs0DflaP5l8K322xoYVD0hzDUGy
        vLzpQ6IDqWOZfLyyGUKwlXHwskJdaP4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-PWxkWJ0kPXK05n7uV02KYQ-1; Mon, 14 Mar 2022 09:57:57 -0400
X-MC-Unique: PWxkWJ0kPXK05n7uV02KYQ-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a0cf300b005f17891c015so11771065qkj.18
        for <linux-rdma@vger.kernel.org>; Mon, 14 Mar 2022 06:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDirMt6DUmLUozphOEbENIKMtwE4Z7punVtOAUrkDBM=;
        b=6oTHPLY9o4EYp6SvogehNhq9kmNKzkEDtkiKXOh/RkJkQoZc9Zib2upqjNuBiVr5EE
         WInp7i3jpBByqacSMP2rL2DPhoZv5myNbZFwlU5vvVLnVS18viBWJljp/8ZiixbBFvtS
         CLaf6b3sCCpbBlPc2mbbD2ssaknkGZ0PO88rr9OtPUrS5cZPKYixik01qFPLh1DYMnX6
         PgvvW2e98FWMChpDqlADfv/m3mjdcbC9NOEMNwnIvGBczPEcoD5/znYgX9fkHRCH+kAm
         MSpIcpgYQJ4t0UA1twB/893LceT2HgjK9zMCeGN3AfeMLv9EvYDf3iTZKX21LCJlEmkl
         3XFw==
X-Gm-Message-State: AOAM5336Nn/xL2BPHBEh1YkbYYbMENmy7cswkTnCy0IjFPyTgf05o2F/
        QUa2JtOT9aYBY6LNfIK3u4YF6a1c3NAsNfkd/HsTIRG4cv+MQIpbsy2MIN0PjlM4BT4k4c6nbGi
        xwKNvFQQovOT+tyTGIlmXcD38ypD0LT1db7Wh3w==
X-Received: by 2002:ac8:5985:0:b0:2e1:deb4:b37f with SMTP id e5-20020ac85985000000b002e1deb4b37fmr102678qte.441.1647266276850;
        Mon, 14 Mar 2022 06:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz59glnj9I5KfdOImXPebst0mBl3mPgApMS5KPvi/5djp0Oj5uUTKTlOz3CQkTPcENc0H9verM1IeXElVVgQkA=
X-Received: by 2002:ac8:5985:0:b0:2e1:deb4:b37f with SMTP id
 e5-20020ac85985000000b002e1deb4b37fmr102658qte.441.1647266276628; Mon, 14 Mar
 2022 06:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220311175713.2344960-1-djeffery@redhat.com> <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
In-Reply-To: <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
From:   David Jeffery <djeffery@redhat.com>
Date:   Mon, 14 Mar 2022 09:57:45 -0400
Message-ID: <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 13, 2022 at 5:59 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
> Hi David,
>
> thanks for the report.
>
> Please check how we fixed that in NVMf in Sagi's commit:
>
> nvmet-rdma: fix possible bogus dereference under heavy load (commit:
> 8407879c4e0d77)
>
> Maybe this can be done in isert and will solve this problem in a simpler
> way.
>
> is it necessary to change max_cmd_sn ?
>
>

Hello,

Sure, there are alternative methods which could fix this immediate
issue. e.g. We could make the command structs for scsi commands get
allocated from a mempool. Is there a particular reason you don't want
to do anything to modify max_cmd_sn behavior?

I didn't do something like this as it seems to me to go against the
intent of the design. It makes the iscsi window mostly meaningless in
some conditions and complicates any allocation path since it now must
gracefully and sanely handle an iscsi_cmd/isert_cmd not existing. I
assume special commands like task-management, logouts, and pings would
need a separate allocation source to keep from being dropped under
memory load.

David Jeffery

