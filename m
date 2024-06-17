Return-Path: <linux-rdma+bounces-3210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5B90B31A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 16:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A52805F8
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939013048C;
	Mon, 17 Jun 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B10/mBrl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568EA12D74D;
	Mon, 17 Jun 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633180; cv=none; b=RS6l9hbXqPVx7CWiihwDPrMHpjIiKsYJqIXKVndrOXmtfjStv0HUhmj56Co6lLvlAUAqZEI4nNiG6rd4fT8X10usHh2L5yndBnttOt6d6XmzjsGXGkxll9wj9vgJ6pINvxP3vfaHurqC2Qo2whm6QoUyIruk0k0sA2/7Vnf+pT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633180; c=relaxed/simple;
	bh=80ZkpjwAKiz6/UORwNjuJxoHs30DWZAw21hpEDNYGn0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ko5SGBdoJh7M4zNXCrWp/VPdh/+9e7lvRRN2lnTEHVzjW4jk34OJLzZCC9s4TpBlDKRlb3rFCdlF87pKCSaSnl0Awl3hWLZ6dtVvtEnCbEHxM8+JScASZBUNAy4y4hIcMnxYZnCPf+tGrA+imGd5Bxy9FlR1WLX0zc+vBQz9XI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B10/mBrl; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718633167; x=1719237967; i=markus.elfring@web.de;
	bh=rAFBHEie0tyE8G1d25IpirjDgFW89pQaM/fImMbeKhw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B10/mBrlkQqWXSMr1hJTR8Jdnlein+KeWU9eMrbCfSe8LCLscuHdyklfvd5KLWF0
	 o9aLayT7UPGwGLbvcExBi/lHH8RIt7CZP13K5QuKGqed7+QSt4dEx7pctEPJUtTOM
	 DFTOdC5ygpzcw0ec8RTOgd62ZI7yQQhDuoC3kal8JdYcmKZvwcINzv5c24hcPvFBJ
	 GB8BCH/Epa0OieimglrXgr2defxR0GGDvGCsT6sibUH6RCbmwX3xeQNF+ZKk9uJE5
	 ZUSRmZkShfz76xEMxMIAv/wqCXHZZ1QzUWx5d1GlwWRUCgwC+Bb40VXZTm2GqUEzy
	 C5d5+4WlIOwkPIeYaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1sCvbi2jQv-0008hB; Mon, 17
 Jun 2024 16:06:07 +0200
Message-ID: <9d13548f-7707-4741-9824-390146462db0@web.de>
Date: Mon, 17 Jun 2024 16:05:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abhilash K V <kvabhilash@habana.ai>,
 Andrey Agranovich <aagranovich@habana.ai>,
 Bharat Jauhari <bjauhari@habana.ai>, David Meriin <dmeriin@habana.ai>,
 Omer Shpigelman <oshpigelman@habana.ai>, Sagiv Ozeri <sozeri@habana.ai>,
 Zvika Yehudai <zyehudai@habana.ai>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240613082208.1439968-2-oshpigelman@habana.ai>
Subject: Re: [PATCH 01/15] net: hbl_cn: add habanalabs Core Network driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240613082208.1439968-2-oshpigelman@habana.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bxkFy6LWoY9U6hOlzw6Od6W0cDm05NCRvqXqGWxxyR0LK6U9tRB
 wXEPJP/oCkw35OIGJ2lZ5PlejFFUvhnV/vSjPBVPxN0f9Wx/a9p5hfFrUZbI25VPeW9uEnN
 MoXDuKof9HFzaT8oDc3VZ74eCzttdDFGzIFa2MOeI4mQmRCVYrYpGdZtXOdgvWv70rs4oTi
 gG30oJ9Zmqp4O9nJZvSeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/XUX4gpEYYc=;owOfkOd1IjGKzAmnsZD3EnQ/DgC
 htmnr7e2oXhtLE60323+++u46bW1UNlqntPulw+WthoxvFJAQmGF9f5O0dPPlaSCy28R8VPff
 oOJ79YUsmrHw8tsBpwgfiDhF2lpOWwAyuLiZy8RJZtD6vr4Uwpk4WBs9RJgFZfqQufw1kcuti
 B7PTygTYlt3m7iobyuyIkImJkvQaA+/3fpdWY+OfkvGuvxwv3DsBTjut+u4ndyR3FTL9oXzF+
 5a43sZqRMKtOA/fRbjY/mbjhBibiURrBF2MGEQJnwpJbvZqcDH25IbshDT759cAZd1aUmPAJw
 WPlj6U+nLQYs/simMrWAmD4gPhn828RcUHvd50rjsN7teFrF+tJGL2fP71XvhUz6PvqT95nD9
 n2udzHjoYeQ8njq6DBZoIyBG3LKn3VO1w9wXqlJWZL9azF9g7MGPz4OSZWjwLswLiB3+rSXPC
 tPOqcAz3Lo5mkWvspogbSSWz1x6cBX82tBkDXV4IikGBoBqc3DOkDAMgPfAPsMe4Ulhl4ZasS
 RgbhMMn4Qb1q/D2mJ6aUhobHUas/I9Eg1j4HZPHD/Da4osH56460Dkfxi+f1yv2j4lX4JR6dx
 Iwr0LrhWZq3Arn2ivmzrj+grOKYviSTmGzEMNdE9xCrOrXWxUA34/6zS+pl8WZQqftyUFpRoe
 A9Ginu6yl4jSYydHK5I1+UDRjSKJWwifiHO4XpgZPDoOAqPANm1PVJIpZtHeZluzMbhW5D/94
 g8HOW7YxjIzbxBie9SHSPpuerawKvodR855dn7UREkIupMU3exh3Y2tmMWXFMaIiSs3GcFGX+
 iMjG8frxGPn+DybcGdyThMNZyQ3owr/GETwN1/sflffDY=

=E2=80=A6
> +++ b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn.c
> @@ -0,0 +1,5954 @@
=E2=80=A6
> +int hbl_cn_read_spmu_counters(struct hbl_cn_port *cn_port, u64 out_data=
[], u32 *num_out_data)
> +{
=E2=80=A6
> +	mutex_lock(&cn_port->cnt_lock);
> +	rc =3D port_funcs->spmu_sample(cn_port, *num_out_data, out_data);
> +	mutex_unlock(&cn_port->cnt_lock);
> +
> +	return rc;
> +}
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(mutex=
)(&cn_port->cnt_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L1=
96

Regards,
Markus

