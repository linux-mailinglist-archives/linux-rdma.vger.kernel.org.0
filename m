Return-Path: <linux-rdma+bounces-17302-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH8dCUTzoWkwxgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17302-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 20:40:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC15C1BCF3E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9AC309859D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492744D695;
	Fri, 27 Feb 2026 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGPijB/I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hpI6powc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860C362135;
	Fri, 27 Feb 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221067; cv=fail; b=hrADkTRQZW1VZQyxLAhnzGFENqVkx/ZzLUjwoaLJ6n4Uwws6JBs7KYVfc5B6P1IqFVcsBXoeeOZLZ7Qbd3fsU3yFgkT2kU0vDiSCAxASVGpdPrxZuDeVHLiVJ3ntw/M1/pxSRL9clKFOIFiE6WWbsBPX2HCF+BkIoTO/aV2U4Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221067; c=relaxed/simple;
	bh=A3drfgWT4J81zJMHkYB9VW6eyWspwZmqvL9HiHp63dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLPN50SZwOLN5lcut9c7yfGa4GIJi6/CWbg9at16lMXSoHOgVsbGgU34gdeu4Fcce5ezX4zELYMC5KSFuMVAJ7hHwgADYaSM0wXc8HdEmC9wXG/SebB7D2miskkW2GGw14XuKet2udg8qoUanuiOP2GH5c0ZpMCvBRDaG9tyrxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGPijB/I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hpI6powc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61REa9Fq2161711;
	Fri, 27 Feb 2026 19:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A3drfgWT4J81zJMHkYB9VW6eyWspwZmqvL9HiHp63dk=; b=
	LGPijB/ImoW1JXd30QrXUeNaT7ceQJpyeFlkUVK8pURFvlefGqiqsFRY/gqyl8lc
	PFlij6GwGxrVvpAkhbb9OpNIfKoS4hh25naJIIrhThiqyZOKghtSSIF1bILRYNEg
	CfdWa3ud4YjE12oi5ucvoS20ri1IGF/zOVIk9+TgrTxKkGfQ5rFY+69MHsAV7bry
	J6XEkrNJq/9z1YrShctKd1LyvcGvv9sAZiD75WPoTEpx6B3mQUVSuuWIAaf2JGxk
	RfEHUyz7okGU4yopNHxfTLj0Og+WX6FMCUaN3HOhw2EZnTTw7Es5RH+1yXXzd3P1
	R+psIKR6fGhGby0eEGWW4Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh01c6bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 19:37:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RInwV7019069;
	Fri, 27 Feb 2026 19:37:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35ehy57-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 19:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuQjkp3GlAm9bMCDL2E9MzA4NkkNBhPSDFC4O85daUw6LCObnUz7JzhjcbiFo6XPh8VvESjCX41KMLh6WWcWQ4qRnum1Y9sIXFvfKKGPm6yoGERp7Kh6wh9dD20V66L7Etg2+x9QdqnizFZgJLI9Dp/v6G1lRagDqsaUF8jmChb4s2vdKrFZIIFvvu3djlSUJpQxlV1OEL5LaNWpFMMn7VWtzaouHcuJbm00NymBX0duXzPuJZ80PmmKPEgO+EIUEyMetmUIBIwL/NYhzxG+y/auKpVCZqbzhXGRo806kFPbNdEmzXYHEBlXxU4wLbAGzpGJWHwSOcNT64PMw3VwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3drfgWT4J81zJMHkYB9VW6eyWspwZmqvL9HiHp63dk=;
 b=Pfh7fpDkS1u7MjXD5s5WYiD2S6mPPaQuLLs/YESx/KLZc+lfpf3H1dtNvefOB+9RomCQaB3HMc2ijhDbQC+a93tdlh7tg3Ngh4RRKt0JnLZQvFwHtvSQq690I3KEIRKZqwK0pIMG1U3g+JILR9pYL8PL2ZKQeU2eLvjQyLpOTjFL3+EaD9VvuplReTWrO01eyG7QFFEhfSYuwWc63Sa+t7KOrt3IFWFBAsdDRc4mqFni5CVJqsI5zOcNoXWVyfxhkwiVUEIvVF+4AySJbQosnIkYyOR4zSwbpTxSa2eGbFvyUEHhD9hNEmdBKvThMzYVp4jDxdTD9RxWr2ZHKqWFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3drfgWT4J81zJMHkYB9VW6eyWspwZmqvL9HiHp63dk=;
 b=hpI6powcrYB2osL1i6SnONXneIgmfxhC7ohE3B2fTESYHl0X6Hes45pyfvBQ8MfrxSyMFuW7pdSXjDjblxYXtN2B5t94aDq8m4x7S8CSePQccxBY2N7ROTEH/TKl3Ujm1QROFreYpGmzWKl5jS+IdUTH4VOHYAE7SlGhNTsD8Dc=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16; Fri, 27 Feb 2026 19:37:36 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 19:37:35 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "edumazet@google.com" <edumazet@google.com>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next] net/rds: Fix circular locking dependency in
 rds_tcp_tune
Thread-Topic: [PATCH net-next] net/rds: Fix circular locking dependency in
 rds_tcp_tune
Thread-Index: AQHcp2fE3+SnqNfUlU+5pLewp1V4rLWVn5OAgAFSpwA=
Date: Fri, 27 Feb 2026 19:37:35 +0000
Message-ID: <05b5da544fdb7c7b3a3c82e8d5dc451f7c4c5737.camel@oracle.com>
References: <20260226213454.85586-1-achender@kernel.org>
	 <CANn89iLGtL+Mka4dww-y+vZpqggMhsNzp5XJbo3RB6RG7=Tgbw@mail.gmail.com>
In-Reply-To:
 <CANn89iLGtL+Mka4dww-y+vZpqggMhsNzp5XJbo3RB6RG7=Tgbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|DS7PR10MB4959:EE_
x-ms-office365-filtering-correlation-id: ec788425-1107-4b8e-0acd-08de7637a88e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 0st9ogpn+PryvhRoz8Dqz2Ffx9ae8Ue7cFlLKfUmtvkmz0dQybetY2rxJ4Ebt8efHmeO8FyYaYkP7uQ9shE4iPn/v7g/V8Urf3x33327EBudHeGTjBMllBqluigLsBhLxubxbrfkgGl6GcGzxL7hwKlDejqRVphLCbLnjBMG6x2d9+8xtpBFUumOCzPiDgYARGOeX5MXfBoEtMqiu0fHNoGvqf4S7zs4B0Rm/cOuop/CenOi+P6bQpv2utpiMtbUGfBmwqetsiEd70fouHkQpYBuYnPEz/eZoSEoDf7j/cY/A/Y+0oQ16LbJlgHIc7Nnu0ZeSgbFqq62cfPraYFBDTm8Ko/PA2X891FVknFUPuw79ieXWHDD2J659RMTryLMH0ZRSDcEZSBGj27oBr6qHe16dCwgZfxJVHpq7M5LhIDrIRF76WR0ptHdFsjpz8toRoNLIRUZggcj1M/kOgggM58XTj97uNIg5LQthQnxW5kQklAze5i3uLG5+SYQam7CvPZfV2TUCUrcxeSC9uvN1TmZcG1oUa3+FNC+AWo0Gh4j08pTysgX0j4I27ytP7cKn1kkWCieFMk4/go459oXTVC7E4yAHmVXEHcM7NUcMKXhKehzP0J0zc8r0stCa4jrhty+lKiZpevn2va1mM56R8b/mzv2QNgSlbOgA1PusP5K2PCSve06fSmCoZ2g6wYN60xUwPSd0IxGGSfv+PfFwIzowxEhuuQ55xKF1f3dk6aqoWfpkud2nQ73foo3mxG/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkhpL1A3a2VIMldMd2hod0ZhV0R0a09hVnZydlVMQnpoTGNYUEpIcTkrS0FW?=
 =?utf-8?B?Q3B3eHBFM0U3cEVBczRjUThKUjR2YUtRNHFRMGZhbWxQQ2ZvL0JYbEp0a21T?=
 =?utf-8?B?RXFSYXdNajkwdHczbWhkKzlYWXorcmtSV2xOOU5tMlhZZTY5bVlPZmlPTDhL?=
 =?utf-8?B?Qnl0NFBwa21PNTcwSzFlK1ppK3cwVG42M0NubVVja2RsaTRpaXpFTUNjdzVS?=
 =?utf-8?B?TnhtSWp6NCsxSS9kbloyTFB3bllXOWh1UFRtNVE0UlpLZFVsdkM0RXY1QjBT?=
 =?utf-8?B?eDI3Z1BpeHU2QXRmeUMvQVpGTUo4YXk5MTF6aE5qMENRVWNNRk5NdmpIaVFv?=
 =?utf-8?B?akVIdHFRV0JyQU5EWWpYd2xDbHJEUVpWcUJNd2VZbSthNzZZeE5PL25pTU5F?=
 =?utf-8?B?US9CeU9WM256Q3NiVzcxNXl4Ly9MM2Q1UytZRDNhbEJCS1B6UlBZUlRaQksx?=
 =?utf-8?B?WWk5bzU1Y1VkcnYrd3phU2kwaHJXekdEalZVSlEwaFZyT0JWUlNsWURmVmNJ?=
 =?utf-8?B?NTBERjlveENldmlUL0VSamthZjM5NHB2ckIyZFg2ZnZyRWRTUTFKU2pTd1pS?=
 =?utf-8?B?MFVidjB3MXRTWDRaOWZhYWZJWjVpYldUMi9tdGlOTFFHOVFRemdILy9HV1hi?=
 =?utf-8?B?L1ovZTRLazJJK25lUWcwSHdHaGNQVUp3Sy8yaVczY2N5MU5tWlRySjhHRFc0?=
 =?utf-8?B?UVJET2haSHBxNkF1MnVQdVNUV2RsZ2N5Uys4T1AyTXkyeTBENlpQSDNnczlZ?=
 =?utf-8?B?R3k2aDJYQ0VuZWRibXJaRnlyZ2VRUUJnQ0N6NTJEd0dOTnIyMmMwcGJ4eHVZ?=
 =?utf-8?B?ZjlWelpqTmcrWEFneUNHdlNZZi92dXlPRjBZVk1XOGViMjhRcHFyZnlsekdx?=
 =?utf-8?B?U3g3UlVLM05qMjUrZUMwNjdUMzlLckVnMWNNaUE2L1hhRy9oWFB5SEVVanpz?=
 =?utf-8?B?MEgrWjFkQmRXZ2tnY1BuR1QzTHlnR2NUM09oQkJsU1hob2xXTEY1ZFY5ODYw?=
 =?utf-8?B?TTkwSE50NVRRS2F0UTNTUXBDTVBGSE9ZSHB1dGEwRjhJMHVvNHZINTBlTGJD?=
 =?utf-8?B?MFFySHBydkdIcDg2SXNXMS9zalBUTEt1dy8xNnZLNnZxMTZ6bFV4bVBQNmVR?=
 =?utf-8?B?WEF5emo3R0pkWDNFZzh6b1BYcVBoRWN4Zmx2S3hyWGtsaDRkNGpDOG4xWmhL?=
 =?utf-8?B?RDNhUXZmckpUZVZmMGRqSjNMYUlIVHYzQjdPUFZGZ0Q0MkpYQTY2a3BBMlJh?=
 =?utf-8?B?ckl6TWVYZDR3ZGczVC9NNVFMYk5xK0MxNXR1aFZkbzZyMk9lVlkxZzZGNy8y?=
 =?utf-8?B?VnRXVmxJVnBFamNPQTVmaFNzV0VYenVIbUgrSC9EM2JiRHZxZmFzLzF3emVE?=
 =?utf-8?B?V1VlRDhneEpKRVE3YjhZTWI4b204K3FtMkVIcmVuQUh3TDZFWVBrT2ZMMUkw?=
 =?utf-8?B?SzJWcmc2c0EyWkpUeDQzRk9UWW1GUU1waUo4dnBma0ZZUWRuOThjcEVBYmpv?=
 =?utf-8?B?K0c3Z1VCeDRqOEZYWFo1ZDFtQzNlQVhuYWVNdkFjZ3J5ZFNpRk1HanZ3Yy9S?=
 =?utf-8?B?bFB1N1UwSE9oVzVOUU44U0ZFeGJUaWpXT2pEUVY4akgwam9xM1hnZkJJazNW?=
 =?utf-8?B?cURadUZTQmU3Slp2UjFpb21MdGFIWkJDVWdFbmJaZnJDMzJITWpsZTZhUTVH?=
 =?utf-8?B?UnRyUHFkS0tjb3c1ak1jZmk0eGw1eUNaSzVYWEs1a3VXUTZ0clhnZmlFb0xV?=
 =?utf-8?B?L0dRMlFQVkgxRzJrMFpkU2VLME1KOWJoWFJacjFCekE5c3pjSE1Ld3F6Qk5s?=
 =?utf-8?B?bUdHaHlzbjIveDZEWEFsS3g0YzljL0N5WmdPOWZGTU1uOEpzd2s4cmpWY0FV?=
 =?utf-8?B?NlYreU44cWxSUWxOdlhxdUVHR2JHVUo2M2dBcHRmQm5NdWVwKzU3UzJ6MXBv?=
 =?utf-8?B?VjF3SnlCYWthdkFLWFNiS2UvUWtSVktuUi9ZNGJjRk1kUGRrU0hzWG9OMjFN?=
 =?utf-8?B?N3JDYlRxdHZ3dE14NVlPWDdtNmNBaGtoNCtnVzNaYW9kVDZGQVFMR2FGcmNG?=
 =?utf-8?B?T2k0bWFVVUY3Ym9EVHJrT1I0K1Nwa3BQTnRSeWdnZGNOZ0VOenZJYU5NY0Yy?=
 =?utf-8?B?RExSVWZKL3VPOVloMG1xSlpUUXYvd3o4d2NiS1RYL1YwRW5hSHFRdzV6NnUw?=
 =?utf-8?B?akxxSGlTaEdkRlRsdnZCaXhXcXU3MmQrcEpPR25SQ1VtU2NyVEdsM3BUWWFi?=
 =?utf-8?B?VlhJZm9pcXI0S21kSUlpY0ZzRk10emVnbzF0dFJrTTF3MFFYdWhhd1RGaW1t?=
 =?utf-8?B?NHIwSjU5cWlGT2h6UFdFOEtqL3RlTlphaW9CYVFnalpsY1dNV0s0ZXZXTmIr?=
 =?utf-8?Q?8figIAyVmxpjXkvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23DC021E44522B499D8921CFCCC598F5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vYaUzIJyNfxSS93M+mtyGmIHSWw55f8JoEXQCE2zk3Q3wl7A4acCl9YPAcQOOZEkDPVLKyDyVDSZyxCagMZppVI/ITNnp8Ou1JGOnX3UcR/7jlGEipqmL3UmQdHyM+pDisZAhc4YoPL+06MtS3nM82qv4P5hAznM8+ktqIyz++1RwkkXl5XiQZ246fbNCKUf7xBjSrUmPC4rklHaM2q+T/IoOjhcPPPhxaU+iRpSaKXEVljzfXDwUQrctPgIfP6O9TsAApQbhvGZ388YA3TAvcIrhTZajtlbFFNlurmeCkkg9SCqnK9Hg+oGRPZYDMOMZGHg2E/KlVjLFqzX532oAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ewytCQ1WtnemwRboTRhszKreDAsSn1VZnHxHobyNsCSFvvK5idbJ8d76PF3Q1AkPQahzcqV6Ms0Ha5RobMNBKjaEWSrCmX816C0bKM1+6MdF7+vYYJ0KobDpdVTgrGxIFviJK+TH9+bTVTaTZD0SzU3j8Kxf7Z2DK1XC/vrbMT9dvpOTX1C9QkwkmKKk9N/tHu6X+Owbsru7h4IsZMmfRRXI1EFPJCp/IpgcCFCgWH7t2JIX4jjlS+jMkrrV7gt6BzQF7gmD6AChQk9qw3WAlI0uyJJMKCWE5wi88Xv4OCXocSebEwJWV+Xfbjk4ap2Z1mS/rfjOmKLdU/tDWGmqlt4xzRZSLTn1qJZRWrm53UNCygpWwPW8pPYQ+kg7uJyLcO48DKGhkRpN52TYVNeuSr1ZTfS0C/qmj0/mAv02xS3RMvezDApdTl1BmLgQfDXBkoY5Qdv405XfnQuVPEqCzATsBcYG72GQX9c+KD6emECWZhDQ8QuYkNb3VZwt9h4/vSaGB8lASxhQAyHDN9saMJFjHMP6R8ZzdV21KxPJ93qlEcrA57wJ0cF+na4HGARCdLoJMAkXs+hpDEk5C0pHeV2/RhXFTsIjdYqXHENuS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec788425-1107-4b8e-0acd-08de7637a88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 19:37:35.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiwGp/sRJoso5f5xw38t3oxAJs8LL5VOHQTyEeJ+IPEGNBoWGzpJbu1hVlfSNQrzP5MTLiPqG/9K82fvF8FnjPHMi5b0pRZsFsCHNjprHWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270171
X-Proofpoint-ORIG-GUID: CJf7kYtwip5RC3ErNf72e4pHz-WcN02f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3MSBTYWx0ZWRfXzUeVghbV4K0H
 +GCJwqJ9ZRBpsmomcqrZNbM3oz3Rlg/lg21L26bjrM0YZ8wsZ/goyqxbUmQer4lnheuJvuds3jU
 Q26fX2CdoRSJ4KKtzsZ+JWsCWNeydA6XfzAqTIJnFmwd4gH33O5gBTkHY67Ok4oWA4u2NqKDGje
 EEZMZdyvqGpJog7OGWx1F4sVYyzwI9Ni0rHsb1oKY99MX7a+75tTUyPsE1Pc5hbYa86Lkcps3h0
 ZZTzeWRNF/lelplpBlHN+qEdjr3E7aZAlR85NmeS56aFxxLMSHw016Geq5W5xuffxriVeHQG5DV
 X7ux2D6ebRqgS1gh9kNoVzUEdwijlqe2Wj2tMNjZfTrhKtOQK8A+7h5/+rY0XVHPE9E26UICBo6
 QbhwCqrr4JcvZE8cE9K9YKW/bMuVxUkVC53AlH5cfFDW/Ooae78AAzJBHp2zrr2xZ7549SQXzfP
 MVy40EsA6MMyg0vXZFQ==
X-Proofpoint-GUID: CJf7kYtwip5RC3ErNf72e4pHz-WcN02f
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a1f284 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8 a=yB18ehxiyxImHnAo_I4A:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-17302-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,appspotmail.com:email,urldefense.com:url,oracle.com:mid,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CC15C1BCF3E
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTI3IGF0IDAwOjI1ICswMTAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IE9uIFRodSwgRmViIDI2LCAyMDI2IGF0IDEwOjM04oCvUE0gQWxsaXNvbiBIZW5kZXJzb24gPGFj
aGVuZGVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IHN5emJvdCByZXBvcnRlZCBhIGNp
cmN1bGFyIGxvY2tpbmcgZGVwZW5kZW5jeSBpbiByZHNfdGNwX3R1bmUoKSB3aGVyZQ0KPiA+IHNr
X25ldF9yZWZjbnRfdXBncmFkZSgpIGlzIGNhbGxlZCB3aGlsZSBob2xkaW5nIHRoZSBzb2NrZXQg
bG9jazoNCj4gPiANCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPiBXQVJOSU5HOiBwb3NzaWJsZSBjaXJjdWxhciBsb2NraW5nIGRl
cGVuZGVuY3kgZGV0ZWN0ZWQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBrd29ya2VyL3UxMDo4LzE1MDQwIGlzIHRyeWluZyB0
byBhY3F1aXJlIGxvY2s6DQo+ID4gZmZmZmZmZmY4ZTlhYWY4MCAoZnNfcmVjbGFpbSl7Ky4rLn0t
ezA6MH0sIGF0OiBfX2ttYWxsb2NfY2FjaGVfbm9wcm9mKzB4NGIvMHg2ZjANCj4gPiANCj4gPiBi
dXQgdGFzayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNCj4gPiBmZmZmODg4MDVhM2MxY2UwIChr
LXNrX2xvY2stQUZfSU5FVDYpeysuKy59LXswOjB9LCBhdDogcmRzX3RjcF90dW5lKzB4ZDcvMHg5
MzANCj4gPiANCj4gPiBUaGUgaXNzdWUgb2NjdXJzIGJlY2F1c2Ugc2tfbmV0X3JlZmNudF91cGdy
YWRlKCkgcGVyZm9ybXMgbWVtb3J5IGFsbG9jYXRpb24NCj4gPiAodmlhIGdldF9uZXRfdHJhY2so
KSAtPiByZWZfdHJhY2tlcl9hbGxvYygpKSB3aGlsZSB0aGUgc29ja2V0IGxvY2sgaXMgaGVsZCwN
Cj4gPiBjcmVhdGluZyBhIGNpcmN1bGFyIGRlcGVuZGVuY3kgd2l0aCBmc19yZWNsYWltLg0KPiA+
IA0KPiA+IEZpeCB0aGlzIGJ5IG1vdmluZyBza19uZXRfcmVmY250X3VwZ3JhZGUoKSBvdXRzaWRl
IHRoZSBzb2NrZXQgbG9jayBjcml0aWNhbA0KPiA+IHNlY3Rpb24uIFNpbmNlIHRoZSBmcmVzaCBz
b2NrZXQgaXMgbm90IHlldCBleHBvc2VkIHRvIG90aGVyIHRocmVhZHMsIG5vDQo+ID4gbG9ja3Mg
YXJlIG5lZWRlZCBhdCB0aGlzIHRpbWUuDQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCsy
ZTJjZjUzMzEyMDcwNTNiODEwNkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+ID4gQ2xvc2Vz
OiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTJlMmNmNTMzMTIwNzA1M2I4MTA2X187ISFBQ1dWNU45TTJSVjk5aFEhSVk5
dl9pRWJibF9xQnRmM2dDaEwyaV9FelBfNU5MQXdEeEFISkhoaVM0ekFlZC1wLXRGdDZMUGkyLTNi
UmZiNTBOb1ExZGFjeWxUeWY0YlFlMnNxM3FzJCANCj4gPiBGaXhlczogNWM3MGViNWM1OTNkICgi
bmV0OiBiZXR0ZXIgdHJhY2sga2VybmVsIHNvY2tldHMgbGlmZXRpbWUiKQ0KPiANCj4gQXJlIHlv
dSBzdXJlIHRoaXMgaXMgdGhlIHJpZ2h0IEZpeGVzOiB0YWcgPw0KPiANCj4gQmVmb3JlIHRoaXMg
cGF0Y2ggd2UgaGFkIGEgR0ZQX0tFUk5FTCBhbGxvY2F0aW9uIGFscmVhZHkgPw0KPiANCj4gVGhp
cyBtaWdodCBpbnN0ZWFkIGNvbWUgZnJvbQ0KPiANCj4gY29tbWl0IDNhNThmMTNhODgxZWQzNTEx
OThmZmFiNGNmOTk1M2NmMTlkMmFiM2ENCj4gICAgIG5ldDogcmRzOiBhY3F1aXJlIHJlZmNvdW50
IG9uIFRDUCBzb2NrZXRzDQpZZXMsIEkgdGhpbmsgeW91J3JlIHJpZ2h0LCBJIHdpbGwgdXBkYXRl
IHRoZSB0YWcgYW5kIHJlLXRhcmdldCB0byBuZXQgYXMgd2VsbC4NCg0KVGhhbmsgeW91IQ0KQWxs
aXNvbg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWNoZW5kZXJA
a2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiAgbmV0L3Jkcy90Y3AuYyB8IDE0ICsrKysrKysrKyst
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3RjcC5jIGIvbmV0L3Jkcy90Y3AuYw0K
PiA+IGluZGV4IDA0ZjMxMDI1NTY5Mi4uZGEyMmIzZGZkYmYwIDEwMDY0NA0KPiA+IC0tLSBhL25l
dC9yZHMvdGNwLmMNCj4gPiArKysgYi9uZXQvcmRzL3RjcC5jDQo+ID4gQEAgLTQ5MCwxOCArNDkw
LDI0IEBAIGJvb2wgcmRzX3RjcF90dW5lKHN0cnVjdCBzb2NrZXQgKnNvY2spDQo+ID4gICAgICAg
ICBzdHJ1Y3QgcmRzX3RjcF9uZXQgKnJ0bjsNCj4gPiANCj4gPiAgICAgICAgIHRjcF9zb2NrX3Nl
dF9ub2RlbGF5KHNvY2stPnNrKTsNCj4gPiAtICAgICAgIGxvY2tfc29jayhzayk7DQo+ID4gICAg
ICAgICAvKiBUQ1AgdGltZXIgZnVuY3Rpb25zIG1pZ2h0IGFjY2VzcyBuZXQgbmFtZXNwYWNlIGV2
ZW4gYWZ0ZXINCj4gPiAgICAgICAgICAqIGEgcHJvY2VzcyB3aGljaCBjcmVhdGVkIHRoaXMgbmV0
IG5hbWVzcGFjZSB0ZXJtaW5hdGVkLg0KPiA+ICAgICAgICAgICovDQo+ID4gICAgICAgICBpZiAo
IXNrLT5za19uZXRfcmVmY250KSB7DQo+ID4gLSAgICAgICAgICAgICAgIGlmICghbWF5YmVfZ2V0
X25ldChuZXQpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVsZWFzZV9zb2NrKHNr
KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFtYXliZV9nZXRfbmV0KG5ldCkpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IC0gICAgICAgICAgICAgICB9
DQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIFdlIGNhbGwg
c2tfbmV0X3JlZmNudF91cGdyYWRlIGJlZm9yZSB0aGUgbG9ja19zb2NrIHNpbmNlIGl0IGlzDQo+
ID4gKyAgICAgICAgICAgICAgICAqIG5vdCB5ZXQgc2hhcmVkLCBubyBsb2NrIGlzIG5lZWRlZCBh
dCB0aGlzIHRpbWUuICBGdXJ0aGVyLA0KPiA+ICsgICAgICAgICAgICAgICAgKiBiZWNhdXNlIHNr
X25ldF9yZWZjbnRfdXBncmFkZSBkb2VzIGEgR0ZQX0tFUk5FTCBhbGxvY2F0aW9uLA0KPiA+ICsg
ICAgICAgICAgICAgICAgKiB0aGlzIGNhbiB0cmlnZ2VyIGFuIGZzX3JlY2xhaW0gaW4gb3RoZXIg
c3lzdGVtcyB3aGljaCBjcmVhdGVzDQo+ID4gKyAgICAgICAgICAgICAgICAqIGEgY2lyY3VsYXIg
bG9jayBkZXBlbmRhbmN5LiAgQXZvaWQgdGhpcyBieSB1cGdyYWRpbmcgdGhlDQo+ID4gKyAgICAg
ICAgICAgICAgICAqIHJlZmNudCBiZWZvcmUgdGhlIGxvY2tpbmcgdGhlIHNvY2tldC4NCj4gPiAr
ICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICAgIHNrX25ldF9yZWZjbnRfdXBn
cmFkZShzayk7DQo+ID4gICAgICAgICAgICAgICAgIHB1dF9uZXQobmV0KTsNCj4gPiAgICAgICAg
IH0NCj4gPiArICAgICAgIGxvY2tfc29jayhzayk7DQo+ID4gICAgICAgICBydG4gPSBuZXRfZ2Vu
ZXJpYyhuZXQsIHJkc190Y3BfbmV0aWQpOw0KPiA+ICAgICAgICAgaWYgKHJ0bi0+c25kYnVmX3Np
emUgPiAwKSB7DQo+ID4gICAgICAgICAgICAgICAgIHNrLT5za19zbmRidWYgPSBydG4tPnNuZGJ1
Zl9zaXplOw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4gDQoNCg==

