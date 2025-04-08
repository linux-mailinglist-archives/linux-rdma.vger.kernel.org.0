Return-Path: <linux-rdma+bounces-9239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735CA8071B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33E61B862BD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCD26E168;
	Tue,  8 Apr 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XDqk4vh9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3726B94D;
	Tue,  8 Apr 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115178; cv=none; b=ZYFR5JQ9CVceREBVgKc09nQmQylBaXdpISGhGluNKg6bUa2vXEYkvEQuUKJfBG51TCdt4BmE8IHgKZNNCqaSCcun+/A/NzhLhsIq19HRdKcf2yoi/AjUnXdUVNoCN5LRhh1v2Xnv9x80o4T3FTITdS2de0jMlrWlDnuCwglMaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115178; c=relaxed/simple;
	bh=XBt0fa3o+SHQtJJi7KxD6TEkR0B5mxrmX9GRwzYZziQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RW1fKuaJhmc4D1E+mhYBZk+JDiB1MeK3IjMQW25XxgxjJJQDYstdqw7i6cDU4vkkf612RSXatto94bEmHXtPTqhnnPrbXhG3qcDLknN5GnBsk66KwAKNU/44FgSIJXWLiSiqPZdUEGZe+54hpfcW27gOicuk7tsTrBeKsjjX+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XDqk4vh9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744115157; x=1744719957; i=markus.elfring@web.de;
	bh=YR3fgynbQAmITjM21eeim2Swds3BhVur9ZFn11e/geY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XDqk4vh9IKjLSMGE+MMfAoWN1b4KoKgYmD+pIDnPKUTQSWDPydRiORzr+eM0koe1
	 79gOiGiyvMMnqYoh9Og4V6tt7fNCpf2hF/q6cYUYvuuzWlXCFfM03UCwQr0m9LzJa
	 X0FAuk2Eg+qgrDweTnwZSQ1jr9jz83v0XdlRPfz+j2cpdh6nwLgb5LjAyZokyMXeL
	 zsyuLJmjJAOeG9LRpmH1Z4JkpLY278x4x9OlOhYk/0CNfwh7vtT44x6rhnhCpMcg0
	 4ASkF4yYPuk5wdyosHWpQXYRuAMagoIzcr1+ns35vjprmHGEBcQIOB4McqPF2WnQu
	 UPqe14LxBVgB7F3kXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVad4-1tajFh23l6-00J6iW; Tue, 08
 Apr 2025 14:25:57 +0200
Message-ID: <5ddf49e1-eea3-4a20-b6f2-fc365b821dea@web.de>
Date: Tue, 8 Apr 2025 14:25:55 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Abeni <pabeni@redhat.com>, Henry Martin <bsdhenrymartin@gmail.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <81d6c67d-4324-41ad-8d8d-dee239e1b24c@redhat.com>
Subject: Re: [PATCH] net/mlx5: Fix null-ptr-deref in
 mlx5_create_inner_ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81d6c67d-4324-41ad-8d8d-dee239e1b24c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Z51ZJGQ8SFjYGbeCTH5SgrQ/i8eMA7rr3zmRC0Up2OFSYAWG5R
 cbrxmaDl+ZK0ZR6ac8/j5n/OVbHrqt0tiqXPN54G3X5JQ8vS1NDJX81xYcgxhgWLa1lydcK
 3xZgblQ8XCcV5q2fDAbVN08yFFog1lCCGLk/vVx39iVMTQvXehnCGIMiSp/MXfgRY/qUN0t
 rBZaQeOTBERUrzGHwyvMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MSKe/KuOTls=;vdkJO7bIHgTkhmHo+EVBc0gGK55
 VXGeYdPxjStKoNmXwu5GVpBT8bWHdoMB/RFmX1BhV6FG1vUeYOvXWOOdkDGloO+g4j0HTvV3e
 5kW+MSQc+c+YCQlOoiNAFzChWYf/zfyPi41PCcrw/PtXK7DWp3FVKA73NFnDiODdyrg5eFOEh
 9gEsuzyMKw8h+Qfo6g4G4CV6mwjWcqj5kUBqmGISsmG1gxZHFJtu5dXC4IeBPy/eA0U66CzhX
 4akDkNBLgGQZfL2LXbcfypwl8bfgHHUItgSXGz5gzTHcycT2wMJJXeUv00LBQE11Z36nWe7Z6
 B1WyWZPRPvpvJoTsWQSqqwUQzCVTBv8siA6pcpuTG3Hw2XUZXEIgdyPjFqBQc/MD/zYh5Jkun
 VUB7ceglPAiuWn1qYhlkvIhWKnI1c3MeyFLaeDEGG1G6hnyQubDpqjs4n9gAQCzkyn2z357EP
 7l5ABzMhM021p6SM21zMM9h/MuTQ2d0I0nkU6GsMk/FXbzWFdcfR6hnW9LbmqSfc/AVKv2Qjl
 mi/tUdxI79HMALIm89Huh9h8WWJhJbV+//0gmXkXgbXhdVL7zfy4EzIGeZ3ihlDWWbv8UsP7Q
 Q+K7orYx3UmUhpprd51zuR5XgQB8IiPO64Qm6Kxk2Yr6D/TQd4axckZyZ8Qs/wW8l4aFdevpY
 7vnzV33+70ivpW+eVAYtvlX5BTL5ex5KJ3c3L5LlmwDCa2iCJLlMbW+GSpLGnhLDacsH3K3O8
 4LgH9X6jkmrycURUKJ5QvZX73mlNq8eiXdUU35sDfOnvy8IzFc+ZOLI79Xh6kUy5Qn0JjvptH
 tnhozYMTFSkAhb7XwA+QXyQlKum+xrIXXhqMcTe4GHaC9nFvWHQK7kmkMsO6nsuznsJO/7e/6
 6yRReWBdhIRuvJSDW1Hi4eyeiTGrzYaxMz5NbOhbc9ZNcXlujsDgAmksZaSKlGj7N3b33Phiu
 /uTUaDxdlIbBHSuhLS6LxvCrFxFXVt7sJpuPzR3uv4bNMLrBaDv/On5a867srMYIRWJgeiR6U
 6oXBr8Jm9S7yC4MCtssCIGIR1A+zkMmCYw8Elf9SBdEJK1SJB/Sft2PJA9B/rclNFqszp8DDk
 CRSqNoYDZZ9Q1UqDjo9PO05kNsAjiT7mJJW49IzzcD8DZTtuP+P8TQdLY4SWPJWHURccr0a2G
 Zr6Fl6scO17RxzqTg08pe/qUiummjNInJLNm0olquMhpI93zh08WzN2Y4foWfxW3shCglCq3H
 k1ImPtuvfSjzMHetuvVgSDUFU7gWS7kZbhIdZL8cAoj2sXETP+MrEh0VlzCbJp3THRLcnz8W/
 d2Hi4P/6Z7nO5fR5LjK3B/qIYRCbUY4t2cu3YWBLnqC/ivuQ3CsjdVgdRsrua21pPv8+jdeBS
 ixdULutYdmGgC13Thb7RdZcTF7UdVNcQMMvrWquKZHOM9PB9ZrkNlq3VvkYi0qrOjLKXSwqMO
 DkmNJp3JMPfbz3IdTMRbkUHQcPMNQBcYbpDw81ydDKM+UFZZy

=E2=80=A6
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> > @@ -655,6 +655,8 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table=
(struct mlx5_core_dev *dev,
> >  	}
> >
> >  	ns =3D mlx5_get_flow_namespace(dev, params->ns_type);
> > +	if (!ns)
> > +		return ERR_PTR(-EOPNOTSUPP);
>
> I suspect the ns_type the caller always sets a valid 'ns_type', so the
> NULL ptr is not really possible here.

Is there a need to mark such a check result as =E2=80=9Cunlikely=E2=80=9D?

Regards,
Markus

