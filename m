Return-Path: <linux-rdma+bounces-17050-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA39IEifm2kX3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-17050-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 01:28:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E1170EE9
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED41C302198C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 00:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3741B3B19;
	Mon, 23 Feb 2026 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="vOtAhch4";
	dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b="LOLFbc4p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0f-003ea501.gpphosted.com (mx0f-003ea501.gpphosted.com [66.159.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C1A256E;
	Mon, 23 Feb 2026 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806526; cv=fail; b=sFIb6X00s23wSI6QtAzVMNPxunI/GID5o+xZ/hOqx0U5h0WxVtA4kOQ/DP3gzRnDXx1Qo4GOV5W+BvDICyIa0pCkcuveCTijoxr8MCS4MWRdGYYw93aMnaI8K7uyWhfCaxSCUibpDXkujYGjdJKNpK9edYC8VbBS77d+Jm100mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806526; c=relaxed/simple;
	bh=A9nLPxDQ+QNpQlc17USzo9rQ2ywJ9UtbxwEBjWa0Upg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J2ZO/GCFSqdymDvHHXLl5B+n16EsqogmqXjzMJdYA0AW0Ffdwi9w4dUr+wI8yg0i8Qhue+YgaBv5jXWcwNIGSnBekCqJZGJXq55VMVOs2J48fJtC/xv9xRvVimUwXMdczhiNVcLipMvLe9lnzzRMqxfr6DveyHS6hzpQ1Wamrnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com; spf=pass smtp.mailfrom=spacex.com; dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b=vOtAhch4; dkim=pass (2048-bit key) header.d=spacexgcchigh.onmicrosoft.us header.i=@spacexgcchigh.onmicrosoft.us header.b=LOLFbc4p; arc=fail smtp.client-ip=66.159.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spacex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacex.com
Received: from pps.filterd (m0418031.ppops.net [127.0.0.1])
	by mx0f-003ea501.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61MNJ4o0008462;
	Mon, 23 Feb 2026 00:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=dkim-cloud1;
 bh=A9nLPxDQ+QNpQlc17USzo9rQ2ywJ9UtbxwEBjWa0Upg=;
 b=vOtAhch4Q6JwgCUbEyXAd4jV2NP8LPTVCMb1Tb1JdZFuDJm3J4FfI2hMiP0JK25DjbfR
 Zumpk4SaQ1lR4Pzs7eAfDU7kXCeAAnrzuZOJsxyrD2ChxNM6rVf5hWkNxTnOlNrdeYmv
 S5W2/m1VdWegjkdpQekb2MDS8poOxs4maZd+HzSfnfxiSEPaiL/rMXwq2K3O+EDA5Bm8
 faSgVeNrX1ff5TF0QkfAhtgMmqRwMmXz7gWuI1g3aALTXKdr42cSnRAolYazLmaoxwPg
 jFFnD//nvUTho86I6T+tCm1r+vTQQ4ITBDispyynDxMSd2ZaN3dbXAlwFC5R2l89oRfj LQ== 
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02on0075.outbound.protection.office365.us [23.103.209.75])
	by mx0f-003ea501.gpphosted.com (PPS) with ESMTPS id 4cgb0882ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 00:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=nMRAu/3G5WQ2/uzUu3lW9BTS9xQiYA+qdYz2RNjh3VaMr6uzzFOOnEArzDO7REYSyxh+45uySj3sRcIugveYRNFgBp8JYq+iNgLFwWCFUBCNiXfQXhGpFxslkG7UUmRCkABiXNeGcHc2gArWU6HP6ZkGk63Aoymqd94hofLBti21y6s3oJ8+1nLPxdkH9sePLpkMFuWeFYaBKBZ0MyW4su/NlOxEbT+VUIzN6EIW9Hp2ohjmVVYSt10zu2+/jF8UB8CiV5XxyRCrk7PB3iY6UkkW/Nz7NmYJe6v3emdgm/XEka0QWNXO9+EmFacJU7nSaW7tKVtQe6Hzd+SdQ9+XHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9nLPxDQ+QNpQlc17USzo9rQ2ywJ9UtbxwEBjWa0Upg=;
 b=So6sy5VXDiwoqoPQ35AFjqXj8sgb6aaKKC6jfkosFaS8cNArWihjSplXRtxcvk2VEB7s031LiE3v1JpBuF9t43bhtsQ+RZztgdnJo9UMbaYfeQV/jYVJ+ywcz23kLsWI8YcgxrMSV5axOz7cylsOjV2yFS1ICFru98iVb34RMFsOu9GBPjZJZpPOVdkgWOyu4XBO1sbjInRkgmljv1jFbjk8xOCp6EBpUrcd1K+tkf/8T0GT131BOkyVMbqceTRlbqzB9cTyyqeY4L8bQZfAVe8uur7wC/c9yX5aSwMyjsAZPL+DjyVWG+WwllAVp1u/WwKMa5EakDZa3PplfJJXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spacex.com; dmarc=pass action=none header.from=spacex.com;
 dkim=pass header.d=spacex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spacexgcchigh.onmicrosoft.us; s=selector1-spacexgcchigh-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9nLPxDQ+QNpQlc17USzo9rQ2ywJ9UtbxwEBjWa0Upg=;
 b=LOLFbc4prEPdmHimHsWW9e+1i1lu1gOSvCFNE77z2bOVByf+ksvDy6AgSJNR0TugDNAGcl0K/wr/EvOZyKgLvfwq/1rTYnTJ8qY+MnUBT1oj8xU8sPbKPdnmuRy0CAS/gLcE3aHHG9F4NHTCDNEs/3/ls1YgPdSvIEqhfksU4jOwdjvY7sYdxN82Ul58vUrrMJWVLlQ9MpajZNlmMNXAB7zoF/Qmq8u57snI40BT/bzwLz3uUPTVicxhbCPMH5lhsLg9Lm1bK1EWzX/c61crOrecZv/lnBJHyED9ZW8ay07/IksNTfLdpa/22TEtLQIiKv7gRwgDck0WjcQnZ0pt+Q==
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18d::6)
 by SA1P110MB1183.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:197::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 00:05:14 +0000
Received: from PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d]) by PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d215:34eb:6fa9:247d%4]) with mapi id 15.20.9611.013; Mon, 23 Feb 2026
 00:05:14 +0000
From: Finn Dayton <Finnius.Dayton@spacex.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Alexei Starovoitov ," <ast@kernel.org>,
        "Daniel Borkmann ,"
	<daniel@iogearbox.net>,
        "David S. Miller  ," <davem@davemloft.net>,
        "Jakub
 Kicinski ," <kuba@kernel.org>,
        "Jesper Dangaard Brouer ," <hawk@kernel.org>,
        "John Fastabend ," <john.fastabend@gmail.com>,
        "Stanislav Fomichev ,"
	<sdf@fomichev.me>,
        "Saeed Mahameed ," <saeedm@nvidia.com>,
        "Leon Romanovsky
 ," <leon@kernel.org>,
        "Tariq Toukan ," <tariqt@nvidia.com>,
        "Mark Bloch ,"
	<mbloch@nvidia.com>,
        "Andrew Lunn ," <andrew+netdev@lunn.ch>,
        "Eric Dumazet
 ," <edumazet@google.com>,
        "Paolo Abeni ," <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Topic: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
Thread-Index: AQHcpFgVNrGrdkK5lkuK7XP5p1ZbYQ==
Date: Mon, 23 Feb 2026 00:05:14 +0000
Message-ID: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1186:EE_|SA1P110MB1183:EE_
x-ms-office365-filtering-correlation-id: cff69ac5-188b-4ef4-762d-08de726f3854
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkdTVW1ZUXp2ajBZZVR0Z2t2dG5YSmRKWDdVRW5kNnVPNUc1VEJtamhhaUdz?=
 =?utf-8?B?UzMxOENFM2pHdkg5REVDblM0enBBWmV4cHZNTkpuQWZtR2dQQVlmYllqdzNB?=
 =?utf-8?B?eGhsVEVYOFJpbmU4elQ1dFFrY0RtRmRzNStkUURpTXJsN3FWUVp2MTZVNHVE?=
 =?utf-8?B?Nm9BVFd4bUxETWE5U0V0YndJcmFleDhsQ2k2VWYvdnhLN2ZSSExPSnE4bGR1?=
 =?utf-8?B?NjRzU05KaGNONitTL09OcWdoOUxqQTNVVml3cnJVc1NHY1RqQStHT2RQS2Q0?=
 =?utf-8?B?bjhBY21Wc0VCbUdrallVYjF2MU1na3NQWWpNeS9Wck95d0RFR25wUTFlR1FV?=
 =?utf-8?B?NkJOWFNnaXFuZ29jdTJMWmNwME1iNlhDL0s4eFF0cEcxNXVMTnFvOHBBMjY4?=
 =?utf-8?B?dHRkRDRJaUV1dmNSUXJ4NTFONlg4dXI3RzQ3dE5XMGRzMjlmSWQwZ0dqZkNO?=
 =?utf-8?B?S3dyY09DM3duWEJPdHl1QmQxSEtqT0JxYUxXL3B3SEdIWG4xS3djZE9OdmlT?=
 =?utf-8?B?NEhEQk0zRXlPaEZaSnlLQXd0dzE3OHZ1ZTNjYkVML01JS1NqRVBYaytNWkVZ?=
 =?utf-8?B?ZDlXaGRmVmZNSzVoT3dtQnEwRzhpR1dCUlJIK2NBWTVDR0xFSDgwYzFOUmJF?=
 =?utf-8?B?N2xrRm4xRU96enJkYUt4VFNkVFRXNE9uQUwxTG1OQ2c0bjVPclh5RG05QXNO?=
 =?utf-8?B?V2F4QXhNUGI4Q0ZHQnlUaUtZUEZJWnl4TERZWHFpUlhXb3B1U3N2R29BZWZw?=
 =?utf-8?B?NC9UbUNnTGtDRWZvYkltRnVmQ2lFY2lZNDJuZSsrY2VUVkpXNnphL1BtNnBn?=
 =?utf-8?B?dUpSQjdvc2hKUEo3R2hmQVBPRlBwRTNlR1BkSzh2bCsyY2dPbHNCWU9IWkEz?=
 =?utf-8?B?NmhsVFBDcXBpcGZBWlFzS2NIMWljVXhjL1dyc1FYUDJENWJsdFU0ZHlGbEtY?=
 =?utf-8?B?WVRCWm05TUVORWFncjlxN0JmSWxwT2JMNHd5bndxS05qRzRrbk95bys2RHhZ?=
 =?utf-8?B?WkdkWjJuTzNFOGNZUzIxdXhEK09lQjRWbjBwdHlmVmxYUVdJdFN1eTl2akg0?=
 =?utf-8?B?cGVaMkpXT0ZqV0o1T3VKcm13Si9QMldPcEZXSEdLM2tUTmxCVy9yN0dUckZW?=
 =?utf-8?B?eGZncnFyQytuRnFiTWpVYUIwNENGQXNEUmdpNU9oWGpDMHJiL2hHRDJZVkNs?=
 =?utf-8?B?K1ZpcnQ4NVh1bjV3Tzh6RUVNNWgyTWRoV2s2MjcwWEl3WnpDNkNBVVEwYTR2?=
 =?utf-8?B?anUrQytDQThDTGdkQzBGbURUWS81NjFVN1Z0Z2lIRVgvR0NJb3pUbm9wemlF?=
 =?utf-8?B?OXY1V0FVa1ZJNno4bGZ4V05nZmhKbGpRUllwbHlnODlTSytPb3VRS0FybitD?=
 =?utf-8?B?NFFWVkVsL2JJS3pralZVTW1JNHlOMGI4OStOTzQ3Y2pYY2toRmc3WVlNM0tz?=
 =?utf-8?B?U3hocy8rc1pMeFRBSi9vTExQa2J3cTBlRFpJYzYrekFqQWpab0xJTXh3SVRP?=
 =?utf-8?B?bUxJTDVQdE5BdmU0dmxlZ2VmMTd1aEtlZmZkRyt4Q1JUL1c0bzZ1aXdzZFIv?=
 =?utf-8?B?ZGRCVzFQS09uMFlaYktVcjNHQlY3ZEZtZU51Rm4wdUxGVm1FVmpQaGpPZGY1?=
 =?utf-8?B?QnVTYm40bzRMaHMvcG9zckVkdmlwcHBHcTJYZUtkUzdndk9VTmhUVHZOU2J4?=
 =?utf-8?B?NEdsTGdHN3VPVUh4RGFyMFMrTUR3cjk0VTcwQ1ZtQWNQaFZDcUxReDFDYnZE?=
 =?utf-8?B?U3dyZDZ4ZGQ4b2NoZ1hPOTdOMm9qM2RyZndYT1lLZWFvWkpmMDF4MzdOU2F3?=
 =?utf-8?B?V0ppSmFJSGUrWmtlOTJrOEFpZXZuY21WdU9QRDV4cEhKN1ZSSzNadFJTZE8v?=
 =?utf-8?B?ajhKY1lwc1kvQm1lWXFhMTJNRHdkUU9vZFFmOHhCZFBESlJDbk1sSW43M3l5?=
 =?utf-8?B?VVJuRHJMTGRGREpxT01wMVV3SXF0cXNRTEllU29KTzF3VnJMbTFMTm1JOUtN?=
 =?utf-8?B?QzB6cmIyN0IxL3BwSmlUUWNCaWlJWmdGTWtLZFYrSWtPcGtLV0FLTUJ6WUE0?=
 =?utf-8?B?aGRRR0lZVW1MMTVMeGxmdk9CVUxCYytFNmNFSUp3cjYydTMvdUhtMjE4cWtI?=
 =?utf-8?B?R3ppR0hvRnB3MTNnbzltMmdHdHpsakszeXNjcFI2cU9PVlhBQnZlaVpZL0t3?=
 =?utf-8?Q?/kk+Pvh4hR7Tqd+IP1KjT9o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFFmbkxSUTNQT3FvczlYSUpnZURWbExrZHBhbXk0NW50eVlNeVA2QldxQlhr?=
 =?utf-8?B?bWsrNnVaeDZ0RG1oQ0RkLzQ3cGtKK1RiTU8zQUFBT0VXWjZzNEdsNnJPMWRo?=
 =?utf-8?B?Rk9XeWtINWpQUEVNcmI4RHZpU1dxOWN0eERab291cWxnRUtzT1ZvbDFKWkJH?=
 =?utf-8?B?VUN0NW5jRmxqZmJTL1BNQ3A3UHZQczdYa3RlRmQ5QTdycUNxRkQvd2RVQ1Yr?=
 =?utf-8?B?d1lReDBYVXFKNWJyUDRGRTdkS2lYREVoSjM2T2hQN3VieFFlbDhBOUVYUkVW?=
 =?utf-8?B?MDBDUTJZWXZZVzJ3ZTlleTU4bVU4KzBtRUxIRXVJdUtINGVZTVU0eFl1ZXdx?=
 =?utf-8?B?NEJZL1hYb1R2NWZpY0RrcnRaeFR1ajZ4cWhzV0ZEY1JYeDAyNGkySVlFdkJV?=
 =?utf-8?B?ZzdMRCtoek1saFF3T2FrK2pzMDlHeVhiZWdKdEZlV3ZNSmU1aVBhdFRTSEpJ?=
 =?utf-8?B?WGcvaWdQZHdQVU50VFJVbktPdGNIUXFEdlpQWmlJYTNmK3NRd2RRcXNjM29E?=
 =?utf-8?B?eWRKQTQycWtvQUVsZkk3Tkt0YXdHYVorcU9NYUVqWW11R0UyZURoSXhiZTNE?=
 =?utf-8?B?dGNkNkxvM1Z6c01XTHdBOHNRTkV5LzhmR1U4dVZiYmNlRHQ4NnBoU2RLaUxy?=
 =?utf-8?B?UnhuVFpjbDNlaFhSWFBSa0RheHBZZnJONGxwWU5tRzAweGtOWUlZK2d2dXhm?=
 =?utf-8?B?anRvYmdIdmFqRWJTTWYrclpxaklBUXd1UHVIclRCTGg2Q2lHb0VZYTdGTHNX?=
 =?utf-8?B?ZEtxOWYza2JucXF4VDVxYitxbVVVMHpLcHM3OUw4SXlyVGFZVEdUOFZTVFEy?=
 =?utf-8?B?RjhGci9nZlp4UmRIYkFzSTNPalAvZWpsbzNKa2hmTXpRVkEreDVQQ1lMTysy?=
 =?utf-8?B?cENvRHc2bTNSeEhacWErVTNxSVByZVExZVB2ektCc3o3QjZQVFpOYS8wdEpH?=
 =?utf-8?B?bERtV2puMDJvSHQ0RjhVQ0IxbUJZc3RlTnBjVFJkaDBJbmZaTlV6YjV0Q2dY?=
 =?utf-8?B?OHdKNjdtQXNnWGNvTnA3ZmN5M2NPT0lOUkEwb3VXSlVrUmV4UEtlRlJ0dVBW?=
 =?utf-8?B?cWt4Z2FHTnZJQ1JESktaMzBpUlRXUEs1SEYwcEVTU0pzSGlMZWloaVB6aVBR?=
 =?utf-8?B?Nm5MaFEvOEhFQWFpTm52blZzblg0Nzg4QmQxb2lXK1BaT0Vqa1JxTy9iRkdO?=
 =?utf-8?B?YWxReFRTK3UyLzFYSVB2Vml4RkU4ZnNxZUhkNkM1VDdSRjJqN3hlRmt4aHZv?=
 =?utf-8?B?SlRKTlg0UTVDQzhoNXp5SlFEVmhuMmRIZkw2RnFoMm9kQktwZkluQmpzMUJG?=
 =?utf-8?B?Mm1hY2RFTmNuNk9jbUlyUnlWd1VkN2dKd0Y4YTNxUkdLeDUvb1ZMQUF3SXRw?=
 =?utf-8?B?dDIzem9zK2d1OUZVTmR4Umc5Qnhua090N1hhVWdTdjlsTnlFUUlHcFplUEJp?=
 =?utf-8?B?bGQ1aTUxc3FXMWdoQW9Ob0VmS1ZGUSswTXJiMkFFc2oxZ0Ria3p3ZnYvbE5X?=
 =?utf-8?B?QUdnQ0kzMHpWaEF5TjNXTVk3NHg3bk1wOWJBZFJZNDJzSExiQjc5WHVibFFU?=
 =?utf-8?B?WHA3V21YUW03ZTRycCs5TW9hVFp3WXVuK0x0a1gvQmxaRUxLLzc4Rnp4aUQr?=
 =?utf-8?B?eWkxb0oxaGpVbjFrT3RES2lPalV1TmZvUGNkc0EycEpvR2RkckNyTlhHY0Zm?=
 =?utf-8?B?Y1IvSE5BdnBIOXFleis1NXVBVHhxWXI3OWhuRVNLRWc4TStrMmtIdFF0aVJ2?=
 =?utf-8?B?Z2dwdzkrWXJZS1QvejBzblFRaVo1UXIxMlJaL0JyTFlaUmplankzYlVlZjIx?=
 =?utf-8?B?VlhoNFJOZ2FSVUJrUjZIRy9lMW5hTWkrcUxENStkKzd4a0xyQnJzVnNmK2hT?=
 =?utf-8?B?M1YvbXFwOCtmU1poRnQ5YVBIb2tCM3lWWFZlSlpLeGw0QXIzWWpvcE5JZHRI?=
 =?utf-8?B?YTc5eWkvV2hWRk9LcmlqbGlaM0RoWkx2SmptT0w0M0MwL2Y5OW5mTVVOQzBU?=
 =?utf-8?B?eFlRdXZBYVJLTFcyZVN2OUprWVEzdTk0UXFZMm9NSm01QTdmQnNwOHZMcHpJ?=
 =?utf-8?B?U2dYOWRVQlhnYkF0K1ZGT1R4OFQvTlVNLzkzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF3D4C19CF562243A33880EE5D2B0837@NAMP110.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: spacex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1186.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cff69ac5-188b-4ef4-762d-08de726f3854
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 00:05:14.5042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70922d1c-6e01-4d95-82dd-55b449e38bd1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P110MB1183
X-Proofpoint-GUID: E_HW_UY41GXETZ4fqmxRYDDUlNfdx3Yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDIzMCBTYWx0ZWRfXxnD1MXOegAd4 Fx+xPlz8n9y4gq6PzC3FRMlZaVVQIyjrZyKbcoSIBMa0qdE11FC75+ZDC5qGT5AcqlBLX8SfhH7 TOCfwN+XtryWx8lxpMtBkI65dxh7OFCkqijGkswSscZbVf8dSw4rSJWFw7wKvSZuFiORn/7II4D
 o4PkLNZUdQP/FtpjeAeItqJ/eHbm+Xo3bslIMz67Z9CiT1mM/HI5sUwpmqB22e9lx7W78FCOMb5 CtHqWLvXPS5PcIf+yqT2rj8SN/ozXrVHFxw4HBiK5YPDp0fxFDTnkwCfvBxo5DqvPjP0QiD9Bxz IeytfArOcfY/Cqf00nKfUBM796LAMLz4rx4fxjiY+cVHCJXx2mQ3i9tNdzbkEvi67Cpk5LzLq/p DepZRLj3
X-Proofpoint-ORIG-GUID: E_HW_UY41GXETZ4fqmxRYDDUlNfdx3Yw
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602220230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[spacex.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[spacex.com:s=dkim-cloud1,spacexgcchigh.onmicrosoft.us:s=selector1-spacexgcchigh-onmicrosoft-us];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17050-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,spacex.com:mid,spacex.com:dkim,spacex.com:email,spacexgcchigh.onmicrosoft.us:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Finnius.Dayton@spacex.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[spacex.com:+,spacexgcchigh.onmicrosoft.us:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 444E1170EE9
X-Rspamd-Action: no action

bWx4NWVfeGRwX3htaXQoKSBzZWxlY3RzIGFuIFhEUCBTUSAoU2VuZCBRdWV1ZSkgdXNpbmcgc21w
X3Byb2Nlc3Nvcl9pZCgpDQooQ1BVIElEKS4gV2hlbiBkb2luZyBYRFBfUkVESVJFQ1QgZnJvbSBh
IENQVSB3aG9zZSBJRCBpcw0KPj0gcHJpdi0+Y2hhbm5lbHMubnVtLCBtbHg1ZV94ZHBfeG1pdCgp
IHJldHVybnMgLUVOWElPIGFuZCB0aGUNCnJlZGlyZWN0IGZhaWxzLg0KDQpQcmV2aW91cyBkaXNj
dXNzaW9uIHByb3Bvc2VkIHVzaW5nIG1vZHVsbyBpbiBtbHg1ZV94ZHBfeG1pdCgpIHRvIG1hcA0K
Q1BVIElEcyBpbnRvIHRoZSBjaGFubmVsIHJhbmdlLCBidXQgbW9kdWxvL2RpdmlzaW9uIGlzIHRv
byBjb3N0bHkgaW4NCnRoZSBob3QgcGF0aC4NCg0KSW5zdGVhZCwgdGhpcyBzb2x1dGlvbiBwcmVj
b21wdXRlcyBwZXItY3B1IHByaXYtPnhkcHNxIGFzc2lnbm1lbnRzIHdoZW4NCmNoYW5uZWxzIGFy
ZSAocmUpY29uZmlndXJlZCBhbmQgZG9lcyBhIHNpbmdsZSBsb29rdXAgaW4gIG1seDVlX3hkcF94
bWl0KCkuDQoNCkJlY2F1c2UgbXVsdGlwbGUgQ1BVcyBtYXAgdG8gdGhlIHNhbWUgeGRwc3Egd2hl
biBDUFUgY291bnQgZXhjZWVkcw0KY2hhbm5lbCBjb3VudCwgc2VyaWFsaXplIHhkcF94bWl0IG9u
IHRoZSByaW5nIHdpdGggeGRwX3R4X2xvY2suDQoNCkZpeGVzOiA1OGI5OWVlM2UzZWIgKCJuZXQv
bWx4NWU6IEFkZCBzdXBwb3J0IGZvciBYRFBfUkVESVJFQ1QgaW4gZGV2aWNlLW91dCBzaWRlIikN
Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI1MTAzMTIzMTAzOC4xMDky
NjczLTEtemlqaWFuemhhbmdAYnl0ZWRhbmNlLmNvbS8NCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi80NGY2OTk1NS1iNTY2LTRmYjEtOTA0ZC1mNTUxMDQ2ZmYyZDRAZ21haWwu
Y29tDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMTIrDQpTaWduZWQtb2ZmLWJ5OiBG
aW5uIERheXRvbiA8Zmlubml1cy5kYXl0b25Ac3BhY2V4LmNvbT4NCi0tLQ0KVGVzdGluZzoNCiAt
IFhEUCBmb3J3YXJkaW5nIC8gWERQX1JFRElSRUNUIHZlcmlmaWVkIHdpdGggYm90aCBsb3cgQ1BV
IGlkcyBhbmQNCiAgIENQVSBpZHMgPiB0aGFuIG51bWJlciBvZiBzZW5kIHF1ZXVlcy4NCiAtIE5v
IC1FTlhJTyBvYnNlcnZlZCwgc3VjY2Vzc2Z1bCBmb3J3YXJkaW5nLg0KDQogZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmggIHwgIDQgKysrDQogLi4uL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMgIHwgMTYgKysrKysrKy0tLS0NCiAuLi4v
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmMgfCAyOCArKysrKysrKysr
KysrKysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL2VuLmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4uaA0K
aW5kZXggZWEyY2QxZjVkMWQwLi4zODc5NTQyMDE2NDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4uaA0KKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuLmgNCkBAIC01MTksNiArNTE5LDggQEAgc3RydWN0
IG1seDVlX3hkcHNxIHsNCiAJLyogY29udHJvbCBwYXRoICovDQogCXN0cnVjdCBtbHg1X3dxX2N0
cmwgICAgICAgIHdxX2N0cmw7DQogCXN0cnVjdCBtbHg1ZV9jaGFubmVsICAgICAgKmNoYW5uZWw7
DQorCS8qIHNlcmlhbGl6ZSB3cml0ZXMgYnkgbXVsdGlwbGUgQ1BVcyB0byB0aGlzIHNlbmQgcXVl
dWUgKi8NCisJc3BpbmxvY2tfdCB4ZHBfdHhfbG9jazsNCiB9IF9fX19jYWNoZWxpbmVfYWxpZ25l
ZF9pbl9zbXA7DQogDQogc3RydWN0IG1seDVlX3hkcF9idWZmIHsNCkBAIC05MDksNiArOTExLDgg
QEAgc3RydWN0IG1seDVlX3ByaXYgew0KIAlzdHJ1Y3QgbWx4NWVfcnEgICAgICAgICAgICBkcm9w
X3JxOw0KIA0KIAlzdHJ1Y3QgbWx4NWVfY2hhbm5lbHMgICAgICBjaGFubmVsczsNCisJLyogc2Vs
ZWN0cyB0aGUgeGRwc3EgZHVyaW5nIG1seDVlX3hkcF94bWl0KCkgKi8NCisJaW50IF9fcGVyY3B1
ICAgICAgICAgICAgICAqc2VuZF9xdWV1ZV9pZHhfcHRyOw0KIAlzdHJ1Y3QgbWx4NWVfcnhfcmVz
ICAgICAgICpyeF9yZXM7DQogCXUzMiAgICAgICAgICAgICAgICAgICAgICAgKnR4X3JhdGVzOw0K
IA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9l
bi94ZHAuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi94ZHAu
Yw0KaW5kZXggODBmOWZjMTA4NzdhLi4yZGQ0NGFkODczYTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW4veGRwLmMNCisrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbi94ZHAuYw0KQEAgLTg0NSw3ICs4NDUs
NyBAQCBpbnQgbWx4NWVfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IG4sIHN0
cnVjdCB4ZHBfZnJhbWUgKipmcmFtZXMsDQogCXN0cnVjdCBtbHg1ZV9wcml2ICpwcml2ID0gbmV0
ZGV2X3ByaXYoZGV2KTsNCiAJc3RydWN0IG1seDVlX3hkcHNxICpzcTsNCiAJaW50IG54bWl0ID0g
MDsNCi0JaW50IHNxX251bTsNCisJaW50IHNlbmRfcXVldWVfaWR4ID0gMDsNCiAJaW50IGk7DQog
DQogCS8qIHRoaXMgZmxhZyBpcyBzdWZmaWNpZW50LCBubyBuZWVkIHRvIHRlc3QgaW50ZXJuYWwg
c3Egc3RhdGUgKi8NCkBAIC04NTUsMTMgKzg1NSwxOSBAQCBpbnQgbWx4NWVfeGRwX3htaXQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IG4sIHN0cnVjdCB4ZHBfZnJhbWUgKipmcmFtZXMsDQog
CWlmICh1bmxpa2VseShmbGFncyAmIH5YRFBfWE1JVF9GTEFHU19NQVNLKSkNCiAJCXJldHVybiAt
RUlOVkFMOw0KIA0KLQlzcV9udW0gPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQogDQotCWlmICh1bmxp
a2VseShzcV9udW0gPj0gcHJpdi0+Y2hhbm5lbHMubnVtKSkNCisJaWYgKHVubGlrZWx5KCFwcml2
LT5zZW5kX3F1ZXVlX2lkeF9wdHIpKQ0KIAkJcmV0dXJuIC1FTlhJTzsNCiANCi0Jc3EgPSBwcml2
LT5jaGFubmVscy5jW3NxX251bV0tPnhkcHNxOw0KKwlzZW5kX3F1ZXVlX2lkeCA9ICp0aGlzX2Nw
dV9wdHIocHJpdi0+c2VuZF9xdWV1ZV9pZHhfcHRyKTsNCisJaWYgKHVubGlrZWx5KHNlbmRfcXVl
dWVfaWR4ID49IHByaXYtPmNoYW5uZWxzLm51bSB8fCBzZW5kX3F1ZXVlX2lkeCA8IDApKQ0KKwkJ
cmV0dXJuIC1FTlhJTzsNCiANCisJc3EgPSBwcml2LT5jaGFubmVscy5jW3NlbmRfcXVldWVfaWR4
XS0+eGRwc3E7DQorCS8qIFRoZSBudW1iZXIgb2YgcXVldWVzIGNvbmZpZ3VyZWQgb24gYSBuZXRk
ZXYgbWF5IGJlIHNtYWxsZXIgdGhhbiB0aGUNCisJICogQ1BVIHBvb2wsIHNvIHR3byBDUFVzIG1p
Z2h0IG1hcCB0byB0aGlzIHF1ZXVlLiBXZSBtdXN0IHNlcmlhbGl6ZSB3cml0ZXMuDQorCSAqLw0K
KwlzcGluX2xvY2soJnNxLT54ZHBfdHhfbG9jayk7DQogCWZvciAoaSA9IDA7IGkgPCBuOyBpKysp
IHsNCiAJCXN0cnVjdCBtbHg1ZV94bWl0X2RhdGFfZnJhZ3MgeGRwdHhkZiA9IHt9Ow0KIAkJc3Ry
dWN0IHhkcF9mcmFtZSAqeGRwZiA9IGZyYW1lc1tpXTsNCkBAIC05NDEsNyArOTQ3LDcgQEAgaW50
IG1seDVlX3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIGludCBuLCBzdHJ1Y3QgeGRw
X2ZyYW1lICoqZnJhbWVzLA0KIA0KIAlpZiAoZmxhZ3MgJiBYRFBfWE1JVF9GTFVTSCkNCiAJCW1s
eDVlX3htaXRfeGRwX2Rvb3JiZWxsKHNxKTsNCi0NCisJc3Bpbl91bmxvY2soJnNxLT54ZHBfdHhf
bG9jayk7DQogCXJldHVybiBueG1pdDsNCiB9DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmMNCmluZGV4IDdlYjY5MWMyYTFiZC4uYWRl
ZjM1ZDA2Yjg5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuX21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL2VuX21haW4uYw0KQEAgLTE0OTIsNiArMTQ5Miw3IEBAIHN0YXRpYyBpbnQgbWx4NWVf
YWxsb2NfeGRwc3Eoc3RydWN0IG1seDVlX2NoYW5uZWwgKmMsDQogCXNxLT5wZGV2ICAgICAgPSBj
LT5wZGV2Ow0KIAlzcS0+bWtleV9iZSAgID0gYy0+bWtleV9iZTsNCiAJc3EtPmNoYW5uZWwgICA9
IGM7DQorCXNwaW5fbG9ja19pbml0KCZzcS0+eGRwX3R4X2xvY2spOw0KIAlzcS0+dWFyX21hcCAg
ID0gYy0+YmZyZWctPm1hcDsNCiAJc3EtPm1pbl9pbmxpbmVfbW9kZSA9IHBhcmFtcy0+dHhfbWlu
X2lubGluZV9tb2RlOw0KIAlzcS0+aHdfbXR1ICAgID0gTUxYNUVfU1cySFdfTVRVKHBhcmFtcywg
cGFyYW1zLT5zd19tdHUpIC0gRVRIX0ZDU19MRU47DQpAQCAtMzI4MywxMCArMzI4NCwzMCBAQCBz
dGF0aWMgdm9pZCBtbHg1ZV9idWlsZF90eHFfbWFwcyhzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikN
CiAJc21wX3dtYigpOw0KIH0NCiANCitzdGF0aWMgdm9pZCBidWlsZF9wcml2X3RvX3hkcHNxX2Fz
c29jaWF0aW9ucyhzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikNCit7DQorCS8qDQorCSAqIEJ1aWxk
IHRoZSBtYXBwaW5nIGZyb20gQ1BVIHRvIFhEUCBzZW5kIHF1ZXVlIGluZGV4IGZvciBwcml2Lg0K
KwkgKiBUaGlzIGlzIHVzZWQgYnkgbWx4NWVfeGRwX3htaXQoKSB0byBkZXRlcm1pbmUgd2hpY2gg
eGRwc3EgKHNlbmQgcXVldWUpDQorCSAqIHNob3VsZCBoYW5kbGUgdGhlIHhkcHR4IGRhdGEsIGJh
c2VkIG9uIHRoZSBDUFUgcnVubmluZyBtbHg1ZV94ZHBfeG1pdCgpDQorCSAqIGFuZCB0aGUgdGFy
Z2V0IHByaXYgKG5ldGRldikuDQorCSAqLw0KKwlpbnQgc2VuZF9xdWV1ZV9pZHgsIGNwdTsNCisN
CisJaWYgKHVubGlrZWx5KHByaXYtPmNoYW5uZWxzLm51bSA9PSAwKSkNCisJCXJldHVybjsNCisN
CisJZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgew0KKwkJc2VuZF9xdWV1ZV9pZHggPSBjcHUg
JSBwcml2LT5jaGFubmVscy5udW07DQorCQkqcGVyX2NwdV9wdHIocHJpdi0+c2VuZF9xdWV1ZV9p
ZHhfcHRyLCBjcHUpID0gc2VuZF9xdWV1ZV9pZHg7DQorCX0NCit9DQorDQogdm9pZCBtbHg1ZV9h
Y3RpdmF0ZV9wcml2X2NoYW5uZWxzKHN0cnVjdCBtbHg1ZV9wcml2ICpwcml2KQ0KIHsNCiAJbWx4
NWVfYnVpbGRfdHhxX21hcHMocHJpdik7DQogCW1seDVlX2FjdGl2YXRlX2NoYW5uZWxzKHByaXYs
ICZwcml2LT5jaGFubmVscyk7DQorCWJ1aWxkX3ByaXZfdG9feGRwc3FfYXNzb2NpYXRpb25zKHBy
aXYpOw0KIAltbHg1ZV94ZHBfdHhfZW5hYmxlKHByaXYpOw0KIA0KIAkvKiBkZXZfd2F0Y2hkb2co
KSB3YW50cyBhbGwgVFggcXVldWVzIHRvIGJlIHN0YXJ0ZWQgd2hlbiB0aGUgY2FycmllciBpcw0K
QEAgLTYyNjMsOCArNjI4NCwxNCBAQCBpbnQgbWx4NWVfcHJpdl9pbml0KHN0cnVjdCBtbHg1ZV9w
cml2ICpwcml2LA0KIAlpZiAoIXByaXYtPmZlY19yYW5nZXMpDQogCQlnb3RvIGVycl9mcmVlX2No
YW5uZWxfc3RhdHM7DQogDQorCXByaXYtPnNlbmRfcXVldWVfaWR4X3B0ciA9IGFsbG9jX3BlcmNw
dShpbnQpOw0KKwlpZiAoIXByaXYtPnNlbmRfcXVldWVfaWR4X3B0cikNCisJCWdvdG8gZXJyX2Zy
ZWVfZmVjX3JhbmdlczsNCisNCiAJcmV0dXJuIDA7DQogDQorZXJyX2ZyZWVfZmVjX3JhbmdlczoN
CisJa2ZyZWUocHJpdi0+ZmVjX3Jhbmdlcyk7DQogZXJyX2ZyZWVfY2hhbm5lbF9zdGF0czoNCiAJ
a2ZyZWUocHJpdi0+Y2hhbm5lbF9zdGF0cyk7DQogZXJyX2ZyZWVfdHhfcmF0ZXM6DQpAQCAtNjI5
NSw2ICs2MzIyLDcgQEAgdm9pZCBtbHg1ZV9wcml2X2NsZWFudXAoc3RydWN0IG1seDVlX3ByaXYg
KnByaXYpDQogCWZvciAoaSA9IDA7IGkgPCBwcml2LT5zdGF0c19uY2g7IGkrKykNCiAJCWt2ZnJl
ZShwcml2LT5jaGFubmVsX3N0YXRzW2ldKTsNCiAJa2ZyZWUocHJpdi0+Y2hhbm5lbF9zdGF0cyk7
DQorCWZyZWVfcGVyY3B1KHByaXYtPnNlbmRfcXVldWVfaWR4X3B0cik7DQogCWtmcmVlKHByaXYt
PnR4X3JhdGVzKTsNCiAJa2ZyZWUocHJpdi0+dHhxMnNxX3N0YXRzKTsNCiAJa2ZyZWUocHJpdi0+
dHhxMnNxKTsNCi0tIA0KMi40My4wDQoNCg0KDQo=

