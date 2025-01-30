Return-Path: <linux-rdma+bounces-7343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27707A2318D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 17:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112961889A64
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23F1EC019;
	Thu, 30 Jan 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b="Unm25p2o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sonic320-23.consmr.mail.bf2.yahoo.com (sonic320-23.consmr.mail.bf2.yahoo.com [74.6.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752081EBFE3
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253440; cv=none; b=ZDil0hhXmpN/AeOp6btlb8QrbKFF4De/fI39bcbgCkYeJeKMGaZi6YNNvZZkkx1kKg8QN2oSOUVauxO0aIlySmjVT+TcDhR31VIUAVmozxv80Kyetc9+P8sDFN3hbQyjjooXDtF85tWN99POdXEFTR8kECfjb7S2suSYezOt6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253440; c=relaxed/simple;
	bh=R2yQezvccBYM6RvfCoKzI6+ahCKgrFYJnAwrGGVbFh4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Z87Kxt/x5u7Xa2iaWbIdHonh4Mvvcs3gANNv3++HjlnljH+sa0cfsvol8nlPkdaEns89hAFdENKjvpb0Jpe71BdRPY5TtjdwWhaRtftlkgItiG4eMPDHpa06+KHmC5GqMZT7/txTt/Msf68NYNOKvoiKLiXZOFvKwdeaMizneaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com; spf=pass smtp.mailfrom=ymail.com; dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b=Unm25p2o; arc=none smtp.client-ip=74.6.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1738253437; bh=R2yQezvccBYM6RvfCoKzI6+ahCKgrFYJnAwrGGVbFh4=; h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Unm25p2oZIssa/kANyldSS23OSUCpdVabUF3hVrxQny0Rdxx21AbaAEC2Xj0DVc6MVdncWaeWqaYOW8yZm4y0UJhFA38w2aMsZjxjES0LA+jqqTknfuImBSSTb8/LAOc9ovtO0L14t3Sz52fozIkRc3erCQ/KoDv1tnzjik+8SLLOoowUztE5g4LspZUskK56JxXT/xidfXCSattmjLasZKrayt0RhfBXhRgtC4/+ZeudPp4qDUKn4O2pewkhsrMxuS56omXtC5U7H7oNQ9IZkg8dxbp2WYkNfdJQnlzQqPzOrq+dhdF5HQQEqcpxZRb2MYeLcpPcg89EtUrMNNQ4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738253437; bh=cc+lem81B5VXvozb5dfxkaHEcz7i3pH6DLmo6UB55cp=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=o/WepzXlKBNI2bjVs7l0kQA9IDlOqvlCUcZ5LgkKU48dRlH3aJv63ICdmDTx2LmHYQdJLSPSk31Ajax2PGtIG5FXwx1HxsHie+y33MitkMCQS7GheA3o7MuWdhF+HUDHjnvBd+s+wSMn52CWwGuCR716z2ABYZw6gwTBXk/SEAgkFfcTbELfZLux/LB0kM+KCgFdDI6tCFDk83AGSfIpxtJDocZAeBqJIZdndjgEVxxS1N6n0zL38/TyUnag2RAZmEtlyrLNwCAD1Bb78p52w+PNCNtjwsdZ6tVY03sBR89kVjRRW9DQdfxLQvpb5JieXTUfjCgkpDuBTCQ72bfdlg==
X-YMail-OSG: dc0jZysVM1nn0NLzdEXuxC6xsC7T8HKfdAbvyxq1tD2kjHQsK_3RCTdDk_wVwUc
 4YZVsrwXboCh2s9.xYfB_Lq1S9H4tX2vpkLmQYhDOjB.t7IEpcL8QsXkYXG2lXjz6N78OPppdV3v
 eKwP5xgcFE67_fKwqxBJJ_cm2CY_vIpoaUogSaIUo140H4SxsZo_8nrNvoN37Wm7eOcbMbedTsFl
 cPp_1IllDfe1GOS4SEwYWr9GvTJNqO9_sLoQb9.4NKRO0rVhu1OYoMtNGuRQOLGitcwfxYgxKwT_
 ZwPBTu58aCbI3JpJ.yjvO1EqH0TKlvqp1wrSjQrJyTN_3rmTH.w6MUyRy0rxf6Sh1dnM7BL5jtnw
 DH9RpoS4Cl87RpU2oWfUPTJ6PireKgI15Rhsvsu7f.6Ai3_xXrwAyFHpS2s7uHcwpR5FEbb7we08
 nhFWjPHoBB7vjZOtNGSFs5qQpiR02Zw_Q5kCPL_sDqZho8WrHjidpxHpw7irOTXF4mcEzjvXmMIj
 Hq54cbxuc9tleShy4xQpm_2Z0EUI41vJ_6OlOS3zJc4gglCPPiTOpTI_EY6IuL_TqhFjsz3qTXMr
 vJP3i4XhBi9gEIAPGiRpwuGBsP0j7mZ3y6vUj4hPLnu7mInkwWrYhYbP4AAVTcOvkVJZG6JrXhcl
 up9vZoaskm7ynApNawBhJdUbgcXiS1Q6TifZ9WYrDdY.zMlZ_PLBDGAdpZbWMV0SzpulXAlbx4xA
 28ZS24JxctpAGKX3r4J8ahwjCoVzzrbNBq9rZ8PtANJPUSwfoRCFtz2HpLrmhuZ5_9nADRVnhQwD
 zvwhdY6xuDUS5lFXLQIScCjJqTyJdP3z357D22.CForefpmH0Ck5yEn9to.t98Kv1xgWJu.mU2BS
 AQSWC_rlRM2rH1w4drHoImbQf3diq4bDw0HVfvRuwRFG9vv6L9c25jVy5YxCGg2rNbES3SzAHEXH
 8BX1Bu9.vFsbxmf.2J_HUAE7yzGwPJUT1fTMUQBpfMY2nru00cbxQPqpWOEzEzwCwrQ7pzSH18LH
 OHnMDCuMsaVFvjDbfZ67NwPNjNkwlQNZAt5TLfyAs3zaSxPk4TiO4xFrZBUC4wcH8NsxHbPxDUbe
 J0Q45UX1PMU6gaG.QJxq96wR7J74RjghVsU5fRZALCws15Y01mmS3mRDIMSD_ynbmdd_EsoPLbsP
 fBzxQQPc3BuE7NBnivT5M7_888kCrGPCPxBeKGSUVg08.az8dRLoGalfQ7MjTmmxv_iX9wY9xpxs
 mzJKmu6uOV6wT8DIlvE_D1E6uCcYAtGgl4POajf33RmTdlXLLiArH3YI1iWskZ2ln5rFcSG1PeUR
 06Lho3BFZ.e4sFRkudkHSNP_nNIBrvxMmqOaWDdFK0AW9p3HK1l7c3iFsf9gXSv70q6UbiCymKje
 DgIHgqMGK8yWXBAof6FNPJzLM0tel2uTR8Kw.7PIccRoRJbaS.vg1K5q4PbAtPl.UtXVNyz1no2J
 RkKOFhnAW93RUj05ZaRTZ6W4B8uOBaU4IOZNF2HSFzsNSaWhOoi0d2vQmOmL1ksUg1IuD2bQcQ3m
 .cdlYY4AJiDUHrajA04nMdc5lM7.BGtdLv9fMV58gsVB1hwXcGjygH53bDHeurs_MPb04BbUUUZX
 5ol9RUhxr7rknvfBYM4w5nkxRDAQQskXVH6lAEb1XITd.lsb6Yg7jCSLYZDotMoanfQZV0SQNYhp
 NfisBqRUZl7FSPP8K7LWpNMtBMBDXIU3eYVk3rjg0Y5dYjvdcRnRbEIkKPX4lR0258jHPxGLvHR8
 QZhtCbezREIp2zJLtl19KzE5lyn0Iml.IxKyIffHpGbzdcVO45lgGDpueTReetntemNmMr0.cpx0
 5HYpz1.LEltL5BVp58IkEG2bu_ZKBPSI_7x3Lq.gYjmm8hCO2NcvPnjoIJxDA.rjqT8Kmil9x2v9
 g5UW0GlE1G.s0PWxWx0Si0X9Prusi9NFQ3P4WoARJgyDoyih8qff6S8gcVzJ_ykXIqAtoHUjLX6f
 _gMAru18P.JZyZ12TKtjvtHjcSfNKWlC3c19dEg0QkmwjFcv611F1LAqUhmppKAV_b5uXsYf.xfL
 3EiGVvF72igfsCPkqWtp64ss8UeIGUEPLZd6wa1kPzMTF3raa4RWyAQqJ92vCRE02Dm9HFsq8Ayp
 llRfFbPZCHkhje7HZd8IMOJDaoOxOJS.pvGEg63_8fht11aClR8hdTMq2FZek0.G.wvncCdDL871
 P9QpbLSDxz32fBMurnRIvIXyfsXR6ADEI1efb_IACmojMA.JRrbMtw7nHvzqpC8d99hkBaA--
X-Sonic-MF: <andrei_ss@ymail.com>
X-Sonic-ID: 1c3eb710-83f8-45c1-ac01-75f7e7c796f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic320.consmr.mail.bf2.yahoo.com with HTTP; Thu, 30 Jan 2025 16:10:37 +0000
Date: Thu, 30 Jan 2025 16:10:36 +0000 (UTC)
From: "Andrei S." <andrei_ss@ymail.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <1820967876.3499649.1738253436582@mail.yahoo.com>
In-Reply-To: <963276744.3495268.1738252591349@mail.yahoo.com>
References: <614323370.3481698.1738248482448.ref@mail.yahoo.com> <614323370.3481698.1738248482448@mail.yahoo.com> <606461795.3488473.1738250979711@mail.yahoo.com> <963276744.3495268.1738252591349@mail.yahoo.com>
Subject: Re: RDMA with IPv6 between 2 NICS on the same host is not working
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23187 YMailNorrin

Hi,

I've noticed that RDMA doesn't work on IPv6 between 2 NIC on the same host.
I've tested with rping and=C2=A0ibv_rc_pingpong. Below you can find the com=
mands and the behavior for each app.

rping test:=C2=A0

> rping -s -a 2001:db8:153:1::10 -p 60009 -V -d=C2=A0// waits for a connect=
ion
> rping -c -a 2001:db8:153:1::10 -I 2001:db8:171:2::20 -p 60009 -V -d=C2=A0=
//=C2=A0client waits indefinitely to connect to server

ibv_rc_pingpong test:

> ibv_rc_pingpong -d mlx5_2 -g 5 // waits for a connection
> ibv_rc_pingpong -d mlx5_3 -g 5 <IPv4 address>=C2=A0 //client throws timeo=
ut error:

local address:=C2=A0 LID 0x0000, QPN 0x000150, PSN 0x23c9c7, GID 2001:db8:1=
71:2::20
remote address: LID 0x0000, QPN 0x00012e, PSN 0x96791a, GID 2001:db8:153:1:=
:10
Failed status transport retry counter exceeded (12) for wr_id 2
parse WC failed 1

What I have noticed with tcpdump on=C2=A0mlx5_3 is that the packets have So=
urce MAC equal to Destination MAC, which is wrong!
Also, I want to mention that both interfaces have also IPv4 addresses and i=
f I'm using IPv4 everything works perfect!

Below you can find my setup:

Ubuntu 22.0.4.5 (6.8.0-49-generic #49~22.04.1-Ubuntu) with 2 NICs connected=
 via a switch.

Network interfaces:

enp153s0np0:=C2=A0
...


inet6 fe80::a288:c2ff:fe7d:a8ca=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<link>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 2001:db8:153:1::10=C2=A0 prefixlen 64=C2=
=A0 scopeid 0x0<global>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether a0:88:c2:7d:a8:ca=C2=A0 txqueuelen 1000=
=C2=A0 (Ethernet)

and=C2=A0

enp171s0np0:
...
inet6 fe80::a288:c2ff:fe7d:a88a=C2=A0 prefixlen 64=C2=A0 scopeid 0x20<link>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 2001:db8:171:2::20=C2=A0 prefixlen 64=C2=
=A0 scopeid 0x0<global>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether a0:88:c2:7d:a8:8a=C2=A0txqueuelen 1000=C2=
=A0 (Ethernet)

Here is the output of the ibv_devinfo:

hca_id: mlx5_2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 transport:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InfiniBand (0)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028.39.1002
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a088:c203:007d:a8ca
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_image_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a088:c203:007d:a8ca
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02c9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_part_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04129
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 board_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MT_0000000838
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_port_cnt:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:=C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PORT_ACTIVE (4)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 max_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
4096 (5)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 active_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024 =
(3)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sm_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lmc:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 link_layer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ether=
net

hca_id: mlx5_3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 transport:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InfiniBand (0)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A028.39.1002
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a088:c203:007d:a88a
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys_image_guid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a088:c203:007d:a88a
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02c9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vendor_part_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04129
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw_ver:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 board_id:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MT_0000000838
=C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_port_cnt:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:=C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 state:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PORT_ACTIVE (4)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 max_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
4096 (5)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 active_mtu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01024 =
(3)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sm_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lid:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 port_lmc:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 link_layer:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ether=
net



Thank you,
Andrei=C2=A0





