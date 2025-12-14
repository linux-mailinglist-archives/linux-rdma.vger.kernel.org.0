Return-Path: <linux-rdma+bounces-14986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC454CBBF9D
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 20:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12E093004C9E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F1314A83;
	Sun, 14 Dec 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUX3RdBn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZIL+4T0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CA283C87
	for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765740910; cv=none; b=PulQdO+2kIxoTFKeuSjf6/x8bCcStcUjv6tjuaN8UFcNt+0TVbR/DTm6kXui25BhYDRLZ4tK+dpJ21fRmfAYm6VnmCKLaVsK5r4QhaL4RCv6t7+j4bfb5YU18NUsa3GbSE9Ey/u0QFTPRwhVnZy0l5SbdA469/ImKrcAN+SjecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765740910; c=relaxed/simple;
	bh=8YfyG2LFyQSDo1pR1jyRp4tNJOWpVpapq9GRPDoXayc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GQBE1P9Y8qcqdYTLPwHUftWaLQ4CtJNeFqOcM4c7PWBIEPFmpszbKvINrgXqiu3J34vomwjDWPOENKFD/UOmmXIOJyz2L3IAVE7xWV87zH9x2EzZ34IWz7xxymOC3mfdeREO2Kae/LNOclDwkuiVZjsj2aATgJPFykDed3AnSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUX3RdBn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZIL+4T0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765740907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4mZnR7UJNODpWMmXymB0wDsddpATfsL+KraTcKuGLw=;
	b=DUX3RdBnu3YK4PvNTO5F4pyX8pRQwlYa3FyCqtNRJuyhcYHK7T8AyrJDFbdxeCDbadKiZs
	Nx6f8cZzE+Gubj8PStv8+6s/4Wp7htz8JPi/RA54X4v4y/gEvRZ6iqsMHgFhF/7G2oc9za
	nS4WilbagbzMA578xcu6YCqYsu4gyNQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-8Kkkv7N2PjW0PGijNdzqYg-1; Sun, 14 Dec 2025 14:35:05 -0500
X-MC-Unique: 8Kkkv7N2PjW0PGijNdzqYg-1
X-Mimecast-MFC-AGG-ID: 8Kkkv7N2PjW0PGijNdzqYg_1765740904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10280so146187f8f.0
        for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 11:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765740904; x=1766345704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4mZnR7UJNODpWMmXymB0wDsddpATfsL+KraTcKuGLw=;
        b=ZZIL+4T00HM8zWwB0PpthG2EaazKPDgaVABUaVM58w1z8j6POUNtO/irCrYqBp9T1/
         0rtEjc2k2eGXXxZP4RYT1V63YASWhy9Punb94boPQjxbm5nf/uciBN7w89I7+SRWuUVG
         S3wzC9m3UcfZvjKDX4/l5pY35nWwK+zls42K16Eve4NTzUGInujyXPKkDtIVzned6U3m
         usPdV2aBXLtqpg87aAoIenM5NwMz3JdN3jBkryr2JcT0JIz3F1ZiYGCz35JmYsyFhPz2
         wc34pp3sKSIMC3C0mWG6woB9IyJDEimMTYaW3uAogJq8UT8qKyXLo7iOeoLNUNlN6WyR
         54/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765740904; x=1766345704;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4mZnR7UJNODpWMmXymB0wDsddpATfsL+KraTcKuGLw=;
        b=tVKygSKS9VB106j12gWVPzOyiMxati4lfGi6ceX+DUcD+AdgQWQP0YA5OXorMWzsaK
         qdmvXACAZ1mM5fRszuqz3kAx+b6w974CWZarcqrOc6xwgOZqFuMHcCzV/SOeldcs8LO5
         YxAN+R+cSixoua3fyQDMI349fQLC7rioAI6E+QgQvF30VUrDsfKKjRc8uJCeqsqPTlI2
         G8V475lJ5u5GW0QNTBkro3MfPkd8wK8klXLi9Q59Yg+gBY2dbmYAj9eFF3p22L/Jx73q
         brcXZ3/N/avVo1p4NhDT1FRQUungRgsi4q8Z9hFTQHBR5BCHdh4up8KK0VozPhp8wCTB
         coSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZrl0TdLjYCnho5X+wdViDHcYR+BX1Zmwp0a3b8mQGEeFFGpnOz60YpQdHRUdTAtwqERpeR24OGQi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8P8oCbAO/x7djfIQJYlHO6xMVZTxKm4+vtgz/EWQRV+aMRbk
	4OYJc94oGH+g/ZrrJw27KExeAlgYu8AeGr2yntpo5clocNz02GWceP3wmfqNtdGLbDTWi3KdGas
	jEF1SivdiIzptamxAB0XD/pmD6AO1GNZ1kMLmZ8oZRjMhrz3w6YvQSEJS1G9a9rw=
X-Gm-Gg: AY/fxX6C/eIbQpHB2hWBX3EBX3WZcS835nvzuJXv4ODpohlpcdviNIOo/bpY9ox5Ad4
	8LxQ/K36E7lZgZ6K/GOuvw870NzzDtT/XY3zVgYlQM2rnBPFknrHxtWNStAgEYv9ZBcZG4ca3Tm
	2l5uv2Bz/ZvN8o4UhYfO50ckgRCHO2yiZiU746S/wPUtgPY7NX8g3Jj9wxLBy6lpAjpPyRRi+Ru
	smz0tseCeftd25iObT2lFNcbSK3Uw0d1z+2CpguesCIUK4sif8YGFQWdxpIC3cWJu1Fg+91WEX1
	u1qpd9WtfGqEXiBcMwYv/suCWvPr++Bqf7mWVhtrDFd+amkSb08oZhvqkeRLWeTpgYXCE2XpQJv
	gpcfCPM8Vy7B48CKq
X-Received: by 2002:adf:f28a:0:b0:42f:bbc6:eda2 with SMTP id ffacd0b85a97d-42fbbc6ee74mr6356757f8f.40.1765740903904;
        Sun, 14 Dec 2025 11:35:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJZygD2dMeXeBlBMcgy1R2+96hGcPhzeLpTRtqAJ2YkZxU6045KWmRjFUtryqBP6cetFCKMQ==
X-Received: by 2002:adf:f28a:0:b0:42f:bbc6:eda2 with SMTP id ffacd0b85a97d-42fbbc6ee74mr6356744f8f.40.1765740903457;
        Sun, 14 Dec 2025 11:35:03 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:11d6:cade:a15:8421])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b6bfsm24464587f8f.43.2025.12.14.11.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 11:35:03 -0800 (PST)
Date: Sun, 14 Dec 2025 20:35:01 +0100
From: Ivan Vecera <ivecera@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_net-next_02/13=5D_dpll=3A_A?=
 =?US-ASCII?Q?llow_registering_pin_with_firmware_node?=
User-Agent: Thunderbird for Android
In-Reply-To: <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
References: <20251211194756.234043-1-ivecera@redhat.com> <20251211194756.234043-3-ivecera@redhat.com> <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
Message-ID: <3E2869EC-61B3-40DA-98E2-CD9543424468@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 12, 2025 12:25:12 PM GMT+01:00, Jiri Pirko <jiri@resnulli=2Eus=
> wrote:
>Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat=2Ecom wrote:
>
>[=2E=2E]
>
>>@@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>>  */
>> struct dpll_pin *
>> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>-	     const struct dpll_pin_properties *prop)
>>+	     const struct dpll_pin_properties *prop,
>>+	     struct fwnode_handle *fwnode)
>> {
>> 	struct dpll_pin *pos, *ret =3D NULL;
>> 	unsigned long i;
>>@@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct mod=
ule *module,
>> 	xa_for_each(&dpll_pin_xa, i, pos) {
>> 		if (pos->clock_id =3D=3D clock_id &&
>> 		    pos->pin_idx =3D=3D pin_idx &&
>>-		    pos->module =3D=3D module) {
>>+		    pos->module =3D=3D module &&
>>+		    pos->fwnode =3D=3D fwnode) {
>
>Is fwnode part of the key? Doesn't look to me like that=2E Then you can
>have a simple helper to set fwnode on struct dpll_pin *, and leave
>dpll_pin_get() out of this, no?

IMHO yes, because particular fwnode identifies exact dpll pin, so
I think it should be a part of the key=2E


