Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA968D72E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 13:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjBGMtQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjBGMtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 07:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D45125A8
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675774103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pNnVVvvF8/Ot6Ip5i4hvaULShyHI18MUkSy36eZSxE=;
        b=YS6HOubElUaqNqip3S5OwnrNYs15OQHaPqLZvj15+XkAblHRIRaYprtRrIL8u32z6u/M+v
        QStWO8oU0qKJS161LrTawH2uRxZ0oYycBH+KvXra3e9jTl8RHTEtlKDtKEGpQzb0DB+kqr
        BVNv2k3+Nc+pBz1nN+s6RzTkj7VJqPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-En_1ad9YM06Furl8axQ44w-1; Tue, 07 Feb 2023 07:48:22 -0500
X-MC-Unique: En_1ad9YM06Furl8axQ44w-1
Received: by mail-qk1-f197.google.com with SMTP id a6-20020a05620a102600b00729952b4c73so9610947qkk.6
        for <linux-rdma@vger.kernel.org>; Tue, 07 Feb 2023 04:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pNnVVvvF8/Ot6Ip5i4hvaULShyHI18MUkSy36eZSxE=;
        b=QT0g1KWneC4FaN3RR4sIcbeHikEWmuFflF2Whx697SOh11ajlTzOKLlvEnbD4uMVzF
         CiU0nt9KlmZR93CnRJtHP4qWDz3DEcHxdGXyp4oHA99Wv8dQWeV5DJK+v8+QMOy3iOUm
         bqwd17ej0icLM1JyZuXSk6cx08iKXIlgGb4DnPCMB3fYBWUzeAN5ayqIL9bMIJ2Y8qx3
         BNTMui7fHspi2U2eIdFzGMGu7zWYOxbQb0o/u6YQlO3yyWbQ/DZbm3IgE2JoAW3EAmeO
         LINNDU2HzbXi85LiW1ivxSzF4LiaYeDICFY9vRt5v307o/8RUW9IXDkz2AN0p7Bzs4st
         shvA==
X-Gm-Message-State: AO0yUKVEyO2zLGlYEbqCSrUCMY8haLZquzxh4qAG1Vno3VuSnkhQUP5q
        BmmsgAvrKFWg6y7ECCv6a6n4MnpPIo5nNn2vBunF55nua0wHYs2cUf2QE1i8PxNnqnnyNFe1gGT
        JWTe3mJIJPxH2oxypt4IY+g==
X-Received: by 2002:a05:622a:4d2:b0:3b6:35cb:b944 with SMTP id q18-20020a05622a04d200b003b635cbb944mr6044710qtx.2.1675774101595;
        Tue, 07 Feb 2023 04:48:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+mQoNSGATnBKIkXvsLl6p0m/4Ku460QBMKXR+jCVcof7QL6e4N6h/kUynB2ZQZ4hY6I+ltGg==
X-Received: by 2002:a05:622a:4d2:b0:3b6:35cb:b944 with SMTP id q18-20020a05622a04d200b003b635cbb944mr6044667qtx.2.1675774101255;
        Tue, 07 Feb 2023 04:48:21 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a20d200b007090f7a4f2asm9344737qka.82.2023.02.07.04.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:48:20 -0800 (PST)
Message-ID: <b25f37e4e11d9da5b6d61cbfaa0cafe9889c3926.camel@redhat.com>
Subject: Re: [net-next PATCH V3 4/4] octeontx2-pf: Add support for HTB
 offload
From:   Paolo Abeni <pabeni@redhat.com>
To:     Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, saeedm@nvidia.com,
        richardcochran@gmail.com, tariqt@nvidia.com,
        linux-rdma@vger.kernel.org, maxtram95@gmail.com,
        naveenm@marvell.com, hariprasad.netdev@gmail.com
Date:   Tue, 07 Feb 2023 13:48:11 +0100
In-Reply-To: <20230206054640.5854-5-hkelam@marvell.com>
References: <20230206054640.5854-1-hkelam@marvell.com>
         <20230206054640.5854-5-hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2023-02-06 at 11:16 +0530, Hariprasad Kelam wrote:
> +static int otx2_qos_txschq_alloc(struct otx2_nic *pfvf,
> +				 struct otx2_qos_cfg *cfg)
> +{
> +	struct nix_txsch_alloc_req *req;
> +	struct nix_txsch_alloc_rsp *rsp;
> +	struct mbox *mbox =3D &pfvf->mbox;
> +	int lvl, rc, schq;
> +
> +	mutex_lock(&mbox->lock);
> +	req =3D otx2_mbox_alloc_msg_nix_txsch_alloc(&pfvf->mbox);
> +	if (!req)
> +		return -ENOMEM;

This does not releases the mbox->lock mutex on error (another
occurrence below).

[...]


> +static int otx2_qos_txschq_update_config(struct otx2_nic *pfvf,
> +					 struct otx2_qos_node *node,
> +					 struct otx2_qos_cfg *cfg)
> +{
> +	int ret =3D 0;
> +
> +	otx2_qos_txschq_fill_cfg(pfvf, node, cfg);
> +	ret =3D otx2_qos_txschq_push_cfg(pfvf, node, cfg);
> +
> +	return ret;

I personally find the plain:

	return <function>

more easy to read - more instances below.

[...]

> +static void otx2_reset_qdisc(struct net_device *dev, u16 qid)
> +{
> +	struct netdev_queue *dev_queue =3D netdev_get_tx_queue(dev, qid);
> +	struct Qdisc *qdisc =3D dev_queue->qdisc_sleeping;
> +
> +	if (!qdisc)
> +		return;
> +
> +	spin_lock_bh(qdisc_lock(qdisc));
> +	qdisc_reset(qdisc);
> +	spin_unlock_bh(qdisc_lock(qdisc));
> +}

The above looks like a possible shared helper, as mlx code implements a
quite identical function.

Cheers,

Paolo

