Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4974DB4C9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiCPP1Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiCPP1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 11:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 054C214005
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647444369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fiyi0AzB53E81OTo2YZCLg9th3nDyr7cwTlg8VafXOo=;
        b=URBD7s5q/1JfNL0qxO+IqtC8LOZ6D/V55cI+RqAXKtEYFte4Hn0bSA37wXOs8i15R0aAcO
        qe91rFbvivrSmexGoS4Dt6VOAzEVNluB9kZeQ4qMgGRS+VKyMEMKDoUm3l87nBCjxb8IQq
        TjR3ovNfduQuKc0j3FePOMtJHMKg5LU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-47dHp7fSNrGmDA8m2Ybthw-1; Wed, 16 Mar 2022 11:26:06 -0400
X-MC-Unique: 47dHp7fSNrGmDA8m2Ybthw-1
Received: by mail-oi1-f197.google.com with SMTP id k26-20020a54441a000000b002da5a65fd5bso1492315oiw.22
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 08:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fiyi0AzB53E81OTo2YZCLg9th3nDyr7cwTlg8VafXOo=;
        b=Ok+IRCP9i73MAgLH38VDkxUhciRE3Z8GPIwvTwOJBSVnIRsqvo5ImsKbcrscGshZgL
         qbM0EYUOLaFZK4qBerRm+/jtkCNNFPOiuwmRdFloIWFXNdchZeC/+CCdqu9diEAbFfVk
         WB9oYuvWwJ0nTtpHa/SH6ZiiQ3bEV7/KiqsQFKXKmj/oZ8fr2wSc7zDOBR0SW+QwhYQq
         ZRTyslGSerHpTln9KsW1Do5CIKtjq/VFyC325hF++SsjvsEVm8eC/pJu6P6reSbMw0bc
         xp3oRp5mr5536aJ6G+JtJTxceMA7rtNjd70PKixIoyH5gdQbVM7jSyorHXLeQfHJXKMe
         8f2g==
X-Gm-Message-State: AOAM533N0ZFCN6rmQNJayk6rAsHXxiMEegamqsRvBqYjGCiuJ2X1aiTb
        iKzUrQr8KZY2HvdGysdUQ+57a129KJOKotI6t6xlqIogzfA2KKBg+b106zgI166M2t5p/i6DeXY
        VuJpW6G5PWxfSCU5rQdB1YQ==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr114714oad.104.1647444365074;
        Wed, 16 Mar 2022 08:26:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd5CO1nlVAFAAJNB90SULBwx2B6wh4kD1JZowYmjPzUhrIR+VsY+TYRoYNtuFzS4AbCfRi2Q==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id y1-20020a056870e3c100b000d72dc87fd0mr114708oad.104.1647444364838;
        Wed, 16 Mar 2022 08:26:04 -0700 (PDT)
Received: from loberhel ([2600:6c64:4e7f:cee0:729d:61b6:700c:6b56])
        by smtp.gmail.com with ESMTPSA id c6-20020a056830314600b005ca1bb396dfsm991322ots.32.2022.03.16.08.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Mar 2022 08:26:04 -0700 (PDT)
Message-ID: <a540823d6f3732903080f42a855d2e7cdfc64ade.camel@redhat.com>
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
From:   Laurence Oberman <loberman@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        David Jeffery <djeffery@redhat.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org
Date:   Wed, 16 Mar 2022 11:26:03 -0400
In-Reply-To: <165698e9-9ccd-c840-b926-48f2ee7c6dcb@grimberg.me>
References: <20220311175713.2344960-1-djeffery@redhat.com>
         <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
         <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
         <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
         <CA+-xHTHK1y7JFAeBN=NVq=vaRBXfRNPbF5ZxmdQ2trhhU+E0tQ@mail.gmail.com>
         <f18f7a350bf5b0f0651083d9a592d35d0d5a68f4.camel@redhat.com>
         <a1cc6842-1429-eea5-aa0d-47b3f2bab843@nvidia.com>
         <720ebd1f98ab3c709443176011f51d6e3ed37272.camel@redhat.com>
         <165698e9-9ccd-c840-b926-48f2ee7c6dcb@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2022-03-16 at 16:39 +0200, Sagi Grimberg wrote:
> Is there any measure-able performance implication?

From our testing and customers it prevented the deadlock, but did not
seem to incur any additional latency. I was reaching similar IOPS/sec
amd GB/sec prior to deadlock.
The benefit seems to be just no more stalls and hung tasks

Thanks for the replies

Kind Regards
Laurence

