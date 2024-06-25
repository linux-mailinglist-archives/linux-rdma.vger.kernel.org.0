Return-Path: <linux-rdma+bounces-3473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B580A91655B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 12:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414BC1F2286C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1014A4C9;
	Tue, 25 Jun 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRbTMOFr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F7132126
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311940; cv=none; b=RpLvVh5XxKN1jxurzhpUcf4+M6kvy4M10Q2lGaM+yZ+wRA9X2Rz8ZIMTSBZn0kk5FaWdY0YNCN6IzW/dWzcKAEAYbxp6E4BatJmTp9VCrqn6MAJ6yTuuL2CS8bi76+WSh9T3tUNQkiSriGaNu5cudXb4jQclzz153d3wJYHjNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311940; c=relaxed/simple;
	bh=qiaDRKJ9OU0itk8Qq39Y68zKDW0sd6VufF9Q6bvuPQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EouygD1SUY4Byzmwq2NANRVXKaO95n910wA0Bg7kkXytxsdNTKBCcFTIfbwxu6mSNIBnTunOVCAln4fKnBFvjdVKWw+eNqb3pZeMg+mDJZi1BmtAeQ/chAfdpL8tcaXwOnBV+Jf5kEsyhZYas1wBA6DXg59DiryyRu0e9UA5B+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRbTMOFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719311937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qnn+HE/4DQ6VV6/b41ap9uey5pQRwjHYKNUh+XSYfco=;
	b=PRbTMOFrYSJjZPv4XJZdn97CxBYIGf+A4nigvuOiOQZqm7T/e2y/6xACknNli4TIyytPhs
	HEScumztSfH0BI/VmyPTV4iEofduO2qFH/Ot/dNTFahdhpiRKIbn5A+PKRNxkIyuswlofP
	mnZZnq77HZIGomhFaG1KFwS6ioYpygQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-YbY9BDZ3PwqG26IEmEHWrQ-1; Tue, 25 Jun 2024 06:38:55 -0400
X-MC-Unique: YbY9BDZ3PwqG26IEmEHWrQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36499139786so598209f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 03:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311935; x=1719916735;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnn+HE/4DQ6VV6/b41ap9uey5pQRwjHYKNUh+XSYfco=;
        b=tYzoRcRmcyEuMOaTHK+rHROfXi6Uzws7w+E989iPa7UBIeCqZWoFR0Jmg0J9mGTBHi
         v2+jKmPy8a4uic5/DncXsFrvXXcQNO+IcCquongUgHn0ZWKa14JBt24b+8N23gI/Ycu3
         ZCVvdVK+kdDWz7oPsxiku3coZ3AlIAHYVyBb7grgtNRtKfcVqwWHTcGZXF0XIEJiFw+i
         U6auI/InpLoZLI5rn2ZJbw4bpSbFHWDbim/WUUzMXQcM2bEJF9eb2qF4nERQ22RWyObb
         J5AB2qqtJBTyDN3QqGsimOv1pnByvYYBUDY7f3/ciagkRSxYDbWrLB4pTrjs+4HWmWeF
         fqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1EXeX0w3yraB8sXjZulXRul++fKpO2+Fb7iSNOr0pVG96Dh99YxEvM90+56l+h95Zg6ExX7ctNVxMytMRNXbSYz0iAFskrB03Ig==
X-Gm-Message-State: AOJu0YxMwlKXqr7UlT5mDzcZd8nTXgrIhywlsG36cOUm6P/Uw+I5zPda
	1OjANsC3BKLJ3goAzkegEXJ8rE4rSIk8lYkrOOA0dHXNtTrq0vqG9zYQe4JyhXuChxiaNYiIKoF
	yTJEF/z78ATGZ0CzyvO+6hVKPLuNDCWXtlwaUBMorGZdU4t+sygE7EApoMbE=
X-Received: by 2002:a05:6000:1864:b0:35f:2e56:7438 with SMTP id ffacd0b85a97d-366e2a63305mr5331546f8f.4.1719311934772;
        Tue, 25 Jun 2024 03:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47rHk5kQLWje2p0LGiRNSBDeyPd/V+UvWBqi7neAWRT8WLHcAw3nmIyaUygygbD9azhevAA==
X-Received: by 2002:a05:6000:1864:b0:35f:2e56:7438 with SMTP id ffacd0b85a97d-366e2a63305mr5331514f8f.4.1719311934353;
        Tue, 25 Jun 2024 03:38:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:da10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638ab8334sm12517357f8f.48.2024.06.25.03.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:38:53 -0700 (PDT)
Message-ID: <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Allen Pais <allen.lkml@gmail.com>, kuba@kernel.org, Guo-Fu Tseng
	 <cooldavid@cooldavid.org>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>
Cc: jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev, 
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
  tlfalcon@linux.ibm.com, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
 stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com,  netdev@vger.kernel.org
Date: Tue, 25 Jun 2024 12:38:51 +0200
In-Reply-To: <20240621050525.3720069-14-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
	 <20240621050525.3720069-14-allen.lkml@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 22:05 -0700, Allen Pais wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the jme driver. This transition ensures compatibility
> with the latest design and enhances performance.
>=20
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/net/ethernet/jme.c | 72 +++++++++++++++++++-------------------
>  drivers/net/ethernet/jme.h |  8 ++---
>  2 files changed, 40 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index b06e24562973..b1a92b851b3b 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -1141,7 +1141,7 @@ jme_dynamic_pcc(struct jme_adapter *jme)
> =20
>  	if (unlikely(dpi->attempt !=3D dpi->cur && dpi->cnt > 5)) {
>  		if (dpi->attempt < dpi->cur)
> -			tasklet_schedule(&jme->rxclean_task);
> +			queue_work(system_bh_wq, &jme->rxclean_bh_work);
>  		jme_set_rx_pcc(jme, dpi->attempt);
>  		dpi->cur =3D dpi->attempt;
>  		dpi->cnt =3D 0;
> @@ -1182,9 +1182,9 @@ jme_shutdown_nic(struct jme_adapter *jme)
>  }
> =20
>  static void
> -jme_pcc_tasklet(struct tasklet_struct *t)
> +jme_pcc_bh_work(struct work_struct *work)
>  {
> -	struct jme_adapter *jme =3D from_tasklet(jme, t, pcc_task);
> +	struct jme_adapter *jme =3D from_work(jme, work, pcc_bh_work);
>  	struct net_device *netdev =3D jme->dev;
> =20
>  	if (unlikely(test_bit(JME_FLAG_SHUTDOWN, &jme->flags))) {
> @@ -1282,9 +1282,9 @@ static void jme_link_change_work(struct work_struct=
 *work)
>  		jme_stop_shutdown_timer(jme);
> =20
>  	jme_stop_pcc_timer(jme);
> -	tasklet_disable(&jme->txclean_task);
> -	tasklet_disable(&jme->rxclean_task);
> -	tasklet_disable(&jme->rxempty_task);
> +	disable_work_sync(&jme->txclean_bh_work);
> +	disable_work_sync(&jme->rxclean_bh_work);
> +	disable_work_sync(&jme->rxempty_bh_work);
> =20
>  	if (netif_carrier_ok(netdev)) {
>  		jme_disable_rx_engine(jme);
> @@ -1304,7 +1304,7 @@ static void jme_link_change_work(struct work_struct=
 *work)
>  		rc =3D jme_setup_rx_resources(jme);
>  		if (rc) {
>  			pr_err("Allocating resources for RX error, Device STOPPED!\n");
> -			goto out_enable_tasklet;
> +			goto out_enable_bh_work;
>  		}
> =20
>  		rc =3D jme_setup_tx_resources(jme);
> @@ -1326,22 +1326,22 @@ static void jme_link_change_work(struct work_stru=
ct *work)
>  		jme_start_shutdown_timer(jme);
>  	}
> =20
> -	goto out_enable_tasklet;
> +	goto out_enable_bh_work;
> =20
>  err_out_free_rx_resources:
>  	jme_free_rx_resources(jme);
> -out_enable_tasklet:
> -	tasklet_enable(&jme->txclean_task);
> -	tasklet_enable(&jme->rxclean_task);
> -	tasklet_enable(&jme->rxempty_task);
> +out_enable_bh_work:
> +	enable_and_queue_work(system_bh_wq, &jme->txclean_bh_work);
> +	enable_and_queue_work(system_bh_wq, &jme->rxclean_bh_work);
> +	enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);

This will unconditionally schedule the rxempty_bh_work and is AFAICS a
different behavior WRT prior this patch.

In turn the rxempty_bh_work() will emit (almost unconditionally) the
'RX Queue Full!' message, so the change should be visibile to the user.

I think you should queue the work only if it was queued at cancel time.
You likely need additional status to do that.

Thanks,

Paolo


