Return-Path: <linux-rdma+bounces-22327-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hpi5CPHcMmok6QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22327-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 19:44:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D61A69BC5C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 19:44:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=vYEbpJq8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22327-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22327-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9C1300C02B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A16363C40;
	Wed, 17 Jun 2026 17:43:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173F3655C3
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 17:43:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718201; cv=pass; b=MgpHHhHgfR0OCOepvuToD0ElTQziI1U57XjZq3dFTkqYAZ3fRSP7A+H9kU/amtCjnDqNtnA4od7SQ4UbFzw3RiAWd3/8NW53dKLlbxFiOrjvU+NRaIzcHTuAiNufJk9Gpm24wZNwUtl8uWYOSRlqQxgokDIFBZIsNUH7+Iz+wy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718201; c=relaxed/simple;
	bh=nKGhKe2QPJgWC88DViyIZHGjzfrkV5gbGiEtwtna2Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZcI9gmVhpORLRk9bRO6yczgpSy96oOmXxn3NvtJS2x2EV70rwi6dBhpAfR7WO7OxoQnb1UU1A+5d1NKRfBHbFZ3Y0QYHf/tj1PN3bIJOTqZ3m77TAZT27jbGsnCUe+wjY0y10Ddg6GJCHuz3K7pXgcUdaj3oFJSxtfOUYmWEQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYEbpJq8; arc=pass smtp.client-ip=209.85.167.45
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad4d840d43so713e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 10:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781718199; cv=none;
        d=google.com; s=arc-20260327;
        b=oTFtyDW/kw8FVdRipLLSfnmNrAvYQjsQdNTletJ2u5EE1aK9kTsE+WVbQuFd7Rx+tp
         M991ovcF2+doDkQo9lKjqeHM3qR6jSWqvRJqps2cQaBMMKMamOqjlilme56fbCn+3XNc
         x0YSFd9i1daYYKZ8R8/Gs6RZM5EHwWjZNhrSu6qcKe+oBMADwICguFjWqIoVKomxyaFi
         +YMsX7P5XV9v3S7bsOw9kYi42OArJfZcWU9Ij1d1E2QIZLnf7ZkiI0Qr6MN51+G8uvWn
         nl/urJ0ytdgX9Bd2Os4La/3BRPFjkQ3BLbd5CF1uLTOVOx8A2rfKhcr8EX7ZUFf/IC+U
         pV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ugxt2MIDxf6/K786KqTT4ogATbxeiL0TXGAdcEx4Adc=;
        fh=Mtgd7Zcm5Eyvp7odePAjM/hdPSxXhakb1lyxo+wLYCY=;
        b=Vve8O3FDLr0I378m+TFkcSIS5jXVGrotUwncAmf6O8HkF8sf6wiJYkW8xh1AoXSUCm
         Dbtsh5bRaW4s4HQokO7pXXeVBrjSqF1aAB1Ffl7+mb++NYdGb9TTHQ85TiTATsTkqsUW
         ziHCrXN48//1XnVdTsigYBfYJXv0Pdb9W3ZWFv3vEccDnPLBL4zgShrVQiXeBn8OU5p+
         ZIIkalwgmgOuw1BYF6kV256+v7VvUcyzywycZ84s98ko46GEYCimcVMGM0ypkOJP8p3b
         EwKF4BO7PitLYcHfBfKsmQNgyey51fLCXeFe96ksAJdSg55c2BhoYvuOUl6Nmm0m3JAp
         uChA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781718199; x=1782322999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ugxt2MIDxf6/K786KqTT4ogATbxeiL0TXGAdcEx4Adc=;
        b=vYEbpJq85xLgrZxOaRshL64bncdMvtn75ZWoL3PrJf6KxEqzDDLi9fEdb7sIgUwokG
         BXI2uRE3H+IOI56CdeMt+7GbNFKZNX8jPJhE2+SvZivuSQSety5uG8Zz50Gno8wMpcSw
         tKc+P1cA72B2oInBhDDWOXWWPBp69bOsIVzssoEk+PpsL+9GDe5Fdzx8BMbJpsUxJzVJ
         rJ/n/Bu02wLi+zao1uGqZKCMGJO/Gmip6gWR/Jn9G7JHEIP7AdlMajhdH7rS66gOE3U5
         Cm8H/YoxW4OJfV0omJjp7gl4ggoP24UDTlqOIK2QYpQDdV0sAHD5ZjNslCUu8Ndi4d4s
         pNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781718199; x=1782322999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ugxt2MIDxf6/K786KqTT4ogATbxeiL0TXGAdcEx4Adc=;
        b=icfgVRixrYxy6DPqLAInSzdXtfJGE8wg/1CVK01AUo4hKUONw72l991A16ZRgfldCB
         eh/KM19dN53C/QcyrwGG1977Y9XYeM5b2UVuZuxYmCRD8QenSArWx5Iv5+Fd6TY7agIq
         b0MyO1flOQZg0UTm4qrYe9CdXPGEFmZPUSN1LF/D4nrrM3jg23prV/wc+IniYm+zNKZy
         oFcsIzblPUo2Pwn5lbuuERw/aD/Kq4dXfSYv/qFOnTkJwdCZl7CMByp+G/sybkcY+Jr3
         leWy4SsEWioRKHr7a92WsQ6ce3d+1xbzY+CU5D0eQLrJz78F0E6GoVOgrDZ3+E1rP2AL
         22HQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CaKB+srjqPV3NjZuWlu+GOPJMcXIYnmyd8GrfS7XWItmXeQIvn5OppFDQUdoeUS6wZ+67JUJxT7tf@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIU1zoLiLvbc6SA2FJVRWD7B8ixCikmsinrRZPsZi32JNj39P
	oxPyypJLuSgvxhNJ9OX4v6rxw6ms+/wNOpzdUK8IYGIv6bz/IDMJd/dhTqKIGM1aBzn0jHxtHlT
	akiD3A0uCYolrPZe04PCmIVSzu+dKeDj7+fbPChM=
X-Gm-Gg: AfdE7clAooJ5XmoUaHd441hB/UjVU1HN6UVrGn9aG2twS9lWuUGwCkesGpGBb/4F8U3
	3aBoCgeoSz+4urAVUxO8Vn2PAfoIM/ixgftFHY2VF5Nkd36wBFBHZCz/BvJTTRQdnyfepCZEFHG
	bs5zLSczgCaPz3R7oepmIbFQ1qmz/2mWC8kS7QDcdk7pHMZWubl9UIV3A04M6XN+WV+ZJ/egq43
	umIIzLL95pFiQLFNhXSIRtmFuFlaH3wD+MGZccopjOIh9E0iFQwjNp1csnHN6AGZDb8
X-Received: by 2002:a05:6512:1287:b0:5aa:8842:241f with SMTP id
 2adb3069b0e04-5ad4dba1941mr2296e87.12.1781718198098; Wed, 17 Jun 2026
 10:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617141154.3219558-1-jmoroni@google.com>
In-Reply-To: <20260617141154.3219558-1-jmoroni@google.com>
From: David Hu <xuehaohu@google.com>
Date: Wed, 17 Jun 2026 13:43:05 -0400
X-Gm-Features: AVVi8Cd9IDacovO9NihgffVLfPcXNgP-a7ZbG_zmzsFL139dgJjC19NiN0fnDv4
Message-ID: <CAPd9Lg8bbtaayaNk7soxZvXAqhS3bEhdby3xuQAKw3NsQegLXA@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Prevent rereg_mr for non-mem regions
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuehaohu@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22327-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuehaohu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D61A69BC5C

On Wed, Jun 17, 2026 at 10:12=E2=80=AFAM Jacob Moroni <jmoroni@google.com> =
wrote:
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index b79f5afe68..da8b4ae786 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -3791,6 +3791,9 @@ static struct ib_mr *irdma_rereg_user_mr(struct ib_=
mr *ib_mr, int flags,
>         if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_AC=
CESS))
>                 return ERR_PTR(-EOPNOTSUPP);
>
> +       if (iwmr->type !=3D IRDMA_MEMREG_TYPE_MEM)
> +               return ERR_PTR(-EINVAL);
> +
>         if (dmabuf_revocable) {
>                 umem_dmabuf =3D to_ib_umem_dmabuf(iwmr->region);

This looks like a good catch for an issue specific to irdma's handling
of queue buffers.

Reviewed-by: David Hu <xuehaohu@google.com>

