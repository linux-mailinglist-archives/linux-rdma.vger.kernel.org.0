Return-Path: <linux-rdma+bounces-15500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6721D185ED
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 12:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBAF302AFB5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A0239E7E;
	Tue, 13 Jan 2026 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="DRzsEkiW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GTwFtPI6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E82BE056;
	Tue, 13 Jan 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302265; cv=none; b=LqfOSyAtlseoIiXFQNULvV2weVA7iYUY6aTzcJzXopscGTLNJc80hr39hgxh14AwM91YI2kigp7sB3++X8lFA26uUUl5fVZPDa0SnJaqUuc7DZ+4M9AQQVem9kclFDDyjG2Rfw9bxEX9LBDJSILt65xicBpRmbSaEdTVxnHrRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302265; c=relaxed/simple;
	bh=EC4C2XIGIUrT7iZ5a0xr9IPkBwnlhsVppr+vB/rvi8A=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=PUZEnIqVcfU1a7ukkUuKAuQZLycaAUd1/JwtOUDl3q4G66NUuwdJM1qWB0exzipNCCwAv2MFLrr7SrEpp9DvYWBRarRQr8njfpXVVGWH2j54OfUFV7LCGLAz1W0EZr1NS7bg5K3sy9GFLntMhfY9JEJ5waQ3ZdHTsn0fKyu46Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=DRzsEkiW; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=GTwFtPI6; arc=none smtp.client-ip=23.251.234.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1768302262;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=EC4C2XIGIUrT7iZ5a0xr9IPkBwnlhsVppr+vB/rvi8A=;
	b=DRzsEkiW2HzlQLgByRA7X5y+6GHRnfIzvEhEELP2hTavAIJR5ooTtdWbF/3vfToG
	qy12M9ZdIhfOmCt7yxwTnax4aEg7OA0T+cuhvDKfa1uChUV9rJ+aGp5VLIrOaBEfWXx
	ygl26ZitrzFnQ4XWPvJgbYQx9rpD1X/znbcCTaQg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1768302262;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=EC4C2XIGIUrT7iZ5a0xr9IPkBwnlhsVppr+vB/rvi8A=;
	b=GTwFtPI6WFU6RY2VC8MRNsAjmdyiLZluJ0t4glHLl8M+ISJzUWzRLmqhmcVnZyc0
	/4esGrfgjQUd0WY1iqb0Tlt6mfrnjvPHUYOIOO5rx/vvAMGZO3AyhyCxewxqAKLbFPD
	6riyhXRG3iWU698ScvyQoJ9ezfZI/I0awB2GHaLs=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <e22a37a6-d15c-4abe-becd-4c538d99ad30@gmail.com>
From: Kenta Akagi <k@mgml.me>
To: ttoukan.linux@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: k@mgml.me, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received
 bits counters to ethtool
Message-ID: <0106019bb70737d5-06bcc3e0-d534-4e42-b8a3-71dc3b53f318-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 11:04:22 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: ::1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.01.13-23.251.234.53

On 2026/01/13 15:43, Tariq Toukan wrote:
>=20
>=20
> On 13/01/2026 8:31, =
Tariq Toukan wrote:
>>
>>
>> On 12/01/2026 9:03, Kenta Akagi wrote:
>>> Hi,
>>>
>>> I would like to measure the cable BER on ConnectX.
>>>
>>> According to the documentation[1][2], there are counters that can be =
used
>>> for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
>>> rx_bits_phy. However, rx_bits_phy does not show up in ethtool
>>> statistics.
>>>
>>> This patch exposes the PPCNT phy_received_bits as =
rx_bits_phy.
>>>
>>>
>>> On a ConnectX-5 with 25Gbase connection, it works =
as expected.
>>>
>>> On the other hand, although I have not verified it, in=
 an 800Gbps
>>> environment rx_bits_phy would likely overflow after about =
124 days.
>>> Since I cannot judge whether this is acceptable, I am posting=
 this as an
>>> RFC first.
>>>
>>
>> Hi,
>>
>> This is a 64-bits counter so=
 no overflow is expected.
>>
>=20
> Sorry, ignore my comment, your numbers =
make sense.
> Maybe it's ~248 days, but same idea.
>=20

Hi, thank you for checking.

Ah, it seems I didn't realize it was unsigned,=
 and I also forgot to
include the expression. Sorry about that.
Yes - at 800 Gbps, 0xFFFFFFFFFFFFFFFF / (800 * (2^30) * 86400) =3D 248.55 =
days,
so it will overflow.

In practice, is it possible to expose this as a=
 statistic via ethtool?
Or is there some other value that could be exposed =
for BER calculation - e.g.,
a register that indicates the elapsed seconds =
since link-up?

Thanks.

>>>
>>> [1] commit 8ce3b586faa4 ("net/mlx5: Add =
counter information to mlx5
>>> =C2=A0=C2=A0=C2=A0=C2=A0 driver =
documentation")
>>> [2] https://docs.kernel.org/networking/device_drivers/e=
thernet/ mellanox/mlx5/counters.html
>>>
>>> Kenta Akagi (1):
>>> =C2=A0=C2=A0 net/mlx5e: Expose physical received bits counters to =
ethtool
>>>
>>> =C2=A0 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |=
 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>
>=20
>=20


