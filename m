Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CA574227F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjF2Ioh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjF2In7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 04:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8D2972
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688028159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
        b=Alr/EKmhy79bwZ4O9Q7RJfYzqgYu7h5Af1xyuy8aVNI1RCX674wCfylb/e5nxm7S1sBPIf
        M/+pIMQ5unn9KQ2tSpBxLCbCwazE8QO9w4nk70IJ25SSfoHh7EpKl0cbshZRZkbF9NBEt7
        XFcJaXoUnBQBj9WFzQPWquMapAQXY5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-HGyLf6ikMzmq1HS7VaoacA-1; Thu, 29 Jun 2023 04:42:38 -0400
X-MC-Unique: HGyLf6ikMzmq1HS7VaoacA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3faf68cb69eso926095e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028157; x=1690620157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7uH2v60++wlSFd3mdA5C25peNy3bqIH/P5Zip2EcJY=;
        b=Pg5XgVv9Z/fogrjW3WUuGartRfjOqao2YWg1Rr4F6VuqtrD3+7r/8h74k2t/mJSeWk
         ivthFvUbfcgoJ0jXBosX4bNMQlnm6ozoVi+UUii71SEEecIOq+zczsSVQK78pTsJUjgk
         0kfSeikIa0vaKS0ugXCQYGRKelK59spocQ9zeP+kgTu3mImRBizwMHq4pHcezFk2g+Bg
         wEtWTMY0zBmy/XizSXZMeA9H4jECtob9WYZ+D5cBChWRJvVRcbsK0nl8JHbtqRkcds3H
         zebhtUlAG86TL3PqpMRIpMX09Uq7x0WZUZzMBz52LaRvG/MTQHj1xelQhcxo11h2KAbx
         HURA==
X-Gm-Message-State: AC+VfDz8cPTFQPQ8FYfCNpi7T3zXXGS/QW1pGb3/PAXbB9b3LPWRNUD7
        s+/ghL8adUtsgNPAt5CqA6EDyezNJqpS1xaLFVWHy3Rgy2qba0OBXEUJtGHZyQWDVGqlkotcHWU
        YS3qprRQERACKQoa/ROtUQQ==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947306wmh.3.1688028157033;
        Thu, 29 Jun 2023 01:42:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+iH2URekcBBIFaPW3s8y3AcFdwpt0qhkGkVRHNjX6kI62bNLzHfSyF8zFoO0Ym2TuJLWyPg==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr38947276wmh.3.1688028156751;
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b003111025ec67sm15279253wrm.25.2023.06.29.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:42:36 -0700 (PDT)
Message-ID: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     longli@linuxonhyperv.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>, stable@vger.kernel.org
Date:   Thu, 29 Jun 2023 10:42:34 +0200
In-Reply-To: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2023-06-26 at 16:57 -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
>=20
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue. Excessive MMIO writes result in CPU spending more
> time waiting on LOCK instructions (atomic operations), resulting in
> poor scaling performance.
>=20
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
>=20
> With this change, tests showed an improvement from 120G/s to 160G/s on a
> 200G physical link, with 16 or 32 hardware queues.
>=20
> Tests showed no regression in network latency benchmarks on single
> connection.
>=20
> While we are making changes in this code path, change the code for
> ringing doorbell to set the WQE_COUNT to 0 for Receive Queue. The
> hardware specification specifies that it should set to 0. Although
> currently the hardware doesn't enforce the check, in the future releases
> it may do.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")

Uhmmm... this looks like a performance improvement to me, more suitable
for the net-next tree ?!? (Note that net-next is closed now).

In any case you must avoid empty lines in the tag area.

If you really intend targeting the -net tree, please repost fixing the
above and explicitly specifying the target tree in the subj prefix.

thanks!

Paolo

