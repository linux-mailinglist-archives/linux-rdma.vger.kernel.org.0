Return-Path: <linux-rdma+bounces-9404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451DA87D58
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2356D3A46ED
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC731EB5F1;
	Mon, 14 Apr 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XKFNuYUZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842925FA04
	for <linux-rdma@vger.kernel.org>; Mon, 14 Apr 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625864; cv=fail; b=h87iXL281u1IrObjNe/5LxTVsBsFg4bKvhoicq8f+aWTTMCAesySEID2pVOTbgflDeqRY5AeVILy8X6rPCIHyjfcZ1K5MFW1W4YrsW7Xb5GgECtJg1mOyJObz2IuivqXiVULCjBx5fVEfOJO67SbD2muMtX5Us00tlgSekgtijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625864; c=relaxed/simple;
	bh=070J9EzggtZiMPD+2LF8N3UWbdoIuK0I7ZOIZiDDMJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZTqnbqhn43L9xdDhhstYVty6hfveDlintOBEuopIVE4KHcPsMdx3YBdlMCkI6wl092r0HNnln4VMUXGWPuoK2K+lPs7ME4tA8bFvpMUiAevngDgY9ZH+5NZgIoUWfzlOFzC2o8idkfRsQS0YZ9Rhqda8h6pkBa/gD30xl//RKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XKFNuYUZ; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1744625862; x=1776161862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=070J9EzggtZiMPD+2LF8N3UWbdoIuK0I7ZOIZiDDMJQ=;
  b=XKFNuYUZFIG3edIQMVHP7IFqeYZcIpdMwA+LwNt9WDVUcCX0DBzoLmwt
   gJCtrgZv563KTqReROAQyMMDqRVR0iN5eP7iPxHEK5/Ieho1oHLDwQABc
   fhy7K2Zr7CLj+bhbkLfaW631SwsNja+hw9hiV56lEHE5LFff8sAh8rcSj
   reQ4QUZZLtPraJ2CN4vKLBwBT6Qv/6tq4oQDTbdBHMApmUyFuHbRL8nz0
   m+z9c3vsMPwbe/heUl3y+i5dgV3ky3NbHgZGLQoeevehu8LO+D4PNVuy+
   kuG0Sptz9jot9G31RM05mOcKyygcHUdEzNbsQxKPHjxTJogz4/lwoZkI6
   A==;
X-CSE-ConnectionGUID: 18Eud0GySUe0mdyNYLoHGA==
X-CSE-MsgGUID: 4VU8++STTXewrCHcSjiEfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="152142608"
X-IronPort-AV: E=Sophos;i="6.15,212,1739804400"; 
   d="scan'208";a="152142608"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 19:16:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT2IppJCnaHrS9wUcJoWeqeyVaV+vJi5SKwUt6GvKhwPVmEPuvgiaJJJCi4pQcTIqkLKKesO2IDCtu5vsjHYbYnXIp4mH79iDjqrF48gMnMpWDyHu6zBGuRjBGquiv8MZysMr0AAiIZoP6zqN5hHYcUHy37IT7xJ+mopIx0PJxtckrO89XXHwuP3aHFFHP17WQM3Tlk5yj/R7WetaVXpY2X37mbsuU7NzgDOA9L/VMFV3GZOmm3nWQdcGSP3ikM3GDMbj336E4TKeazip+F4qjiyOIi62aREFup3f7b1rR+e3f3/g3N7NfhXPpFAPgIgy3vbXB2Uc9jLKZtw27PGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZS0xU58H8+gDRGc3a4BeS1iNjIj61F4L7+vpK0Ju4s=;
 b=BrPcqpXuzs13XB683ns4pnx0u/8jYQ5tBhMst7LfEiLrkJiyv56h+/aQ0z7/ApOgKmXWc2v2tEFMI0BT4GTQhwiBPxLefuwT0uo/VuWoI8rLibrBvLBd0PlHLTc30n4SzIKV3r6g6twmG6r4C0dtZhHNaMVVsaiNgNujR1CsrOfUX6hLSdkfgK41xfghhrmjG6rXEvI1mSEUTkfYyXMy6jiwTK51x0SK4n+IgWzNLHk3aVsIYJ7/qxnWUHxTyM+zwUkEMWOfj7+CZXptjyHLppC2Ikf0tlTdE72dsjWyFDfixIJWs4k+7xubx83W3wmeAtjQcL71jLQTnvnyhy7F6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYYPR01MB6857.jpnprd01.prod.outlook.com (2603:1096:400:d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 10:16:20 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 10:16:20 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Topic: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Index: AQHbnJJQp2nOjxjI7Uy0N2Ugx/pysbOZtPEAgAR6eKCAAK1DAIAELPsw
Date: Mon, 14 Apr 2025 10:16:19 +0000
Message-ID:
 <OS3PR01MB9865CBFAA8DAA73AA42C6D95E5B32@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
 <174411071857.217309.12836295631004196048.b4-ty@kernel.org>
 <OS3PR01MB986530139AE70B2D0BB6C111E5B62@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250411175528.GX199604@unreal>
In-Reply-To: <20250411175528.GX199604@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=7466a617-20bd-40f0-a9a0-d1f2043e7ce5;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-04-14T09:41:29Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYYPR01MB6857:EE_
x-ms-office365-filtering-correlation-id: 192ada05-b4ff-49f7-8ea6-08dd7b3d668a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aG85dkgyL2tibDdlbUxHWTBYV25MQ2FUd0RIa3Y2dFpWbVdTV3VNdjJJ?=
 =?iso-2022-jp?B?eURLSEcySjBuTmZMbE9FVFoyeGFqRUc4eFAva0Jac1M2SU5YcUZ3bndi?=
 =?iso-2022-jp?B?QTA2WExOTkwwWXZmb3p3NUhsa1RhRE9xNys1ZWJUTDN2UGpHek15VUxF?=
 =?iso-2022-jp?B?VGovVlgwYWlEYllUM1F1OEhORUxEQTVQbVVJRFlOMStNTzhpazhCSUMz?=
 =?iso-2022-jp?B?NUIrb1NvcnVwallYbDhIc080RU90UDN0TW5sYjYrY0dUYkpXWjNKOUdi?=
 =?iso-2022-jp?B?ZGhqTnFGZ1VxT2gxR3FYYnFEcEx1TDlCV08yMVRSR0s0bTJ0bzNkRDRX?=
 =?iso-2022-jp?B?cGFVcThydFNyVmZWTjhMQnRjQXJTN3NQdzdQNHJGVzVFVmFlR3UxVDBn?=
 =?iso-2022-jp?B?TVh2c1pIRXVCamtvT3ZRS3pweWhNRTZpR2hvbk9FNzRxaHhCZTVwY1BS?=
 =?iso-2022-jp?B?eGFGb3ZhdGRWRXhESy9nd3Rzb1pHZllodXlYVGNJMzUxN2RvcHZoa1U3?=
 =?iso-2022-jp?B?dmRRSHUvZERSUEt0bUo1NGhURG1LMDRkMG85R3B6a3ZxNy9Bd3VqVFRQ?=
 =?iso-2022-jp?B?QU9Vc08xeHdHV2NrUXFWWjNSUXRhNTVqWFJscWFoVjdNRzN1NnJsUFIz?=
 =?iso-2022-jp?B?aUplZVdLZGd3NlNldlZZVlRtTzhvTllVN0dLQStDUUhCN0k5ZnE3Snp2?=
 =?iso-2022-jp?B?clB6aXZicGtiT1dXVkpSVEpkeU9PNzQxSXJjMnJOYmZZaTNROVM3VThK?=
 =?iso-2022-jp?B?MG1TdFAyL0phMmgrZVNtNit2WWtaNEppQm5McTBhTnJRY2tmQUIwTHBT?=
 =?iso-2022-jp?B?OTlTZlUwck8wTXozeWkyRnhPY2wrVEFuNnJKRDRKN3piWUQ5UEFXaGM3?=
 =?iso-2022-jp?B?bzIvdk1vaWZiMmlFdGRlUVRaQXZxUUltQnBaMWJueTRYdThBb0lGaFlV?=
 =?iso-2022-jp?B?UUh2L1VZY3dzL2dnOHpCV3lxeWJuNGpiaWdFQ3ZrR3F1cm01QUlUa3Jp?=
 =?iso-2022-jp?B?QmwxbHlkY21pQkNsUVpMV1QzbG0zWG5XMVZ1QlBkNjhEaFNOcDVwdE9Z?=
 =?iso-2022-jp?B?NVlIU0xoOWtKYlFwYTR4MnBVRXFFY0UwSFNHMitJMFFkV0VNUzFrdWNK?=
 =?iso-2022-jp?B?UGxkUlJsbnYxSXYvME1aOUxxcHBQWlpTUTJNUXE3ZS95UmJkUUFYc3NX?=
 =?iso-2022-jp?B?bFFUUm5yNHRoRDVwRGFvYWxTNlRoRUt5eHBhRy9HM05IY3B0WnZMZkg4?=
 =?iso-2022-jp?B?WDFsZzZLbk9WRE82S2VPai9pNmRJZnhuSGVlWUYzbHFHZyt1RWZ0RHNJ?=
 =?iso-2022-jp?B?NDVJK3p4YkR4VVlQemdYNVBzbWlNemdycWpxUHZPNmRJSnFEN0k1RFhH?=
 =?iso-2022-jp?B?elMrejIwNVdMS1l2RTViem9nWEVETVlCazlvc3RxN0NYV3lwV0ZHZXBO?=
 =?iso-2022-jp?B?TmJnWktYejhuN29VVkprZ3VSS2ExeGxGM2ZtSHZDQzJBRHZteDFKZU9I?=
 =?iso-2022-jp?B?S2hqMjBpZU4zdkNMSVRtMzJjTFRvb2pxakhyTjV1STB1RnFpMXVra2Nz?=
 =?iso-2022-jp?B?ekVJMHUxMkFwNXlvWDhmSDIxTGZqejM5QWZ3eVMveE95VW9iQnlQSnln?=
 =?iso-2022-jp?B?UHlTVm5GRlgxZHhlWEdQTXAraHl1Qy8zQXFDM2VKME1tMUNuSXh6YTJN?=
 =?iso-2022-jp?B?SUNGTHVGeEl1QnhzS0w4cXVmc3JNU3VlZEdwSUlvaTVZRUhDODdHd1Zu?=
 =?iso-2022-jp?B?NXVicUdNaGoyckFJVEI5SUd0cTM0cVhSdXJBMStleWgyYXJYWlB4TGZw?=
 =?iso-2022-jp?B?NTdWZDRKeEExNXRGUTRGMU02MGFITmpURU0xUzUxTnIwMGJpc01MaFRt?=
 =?iso-2022-jp?B?czkxa0d6Yk1sQUFXTHlZRWdvVXI3QzBTL1NZWUt6MkJXc0lTNVRoMDly?=
 =?iso-2022-jp?B?NXFxOGsyemtadWtJekZERVpjOUszM254MWUvN05VbGovWjlGM1N6bUVD?=
 =?iso-2022-jp?B?MFNzeEVnWW9aUUZqaW5iMStIZHA3WXptK01HUEZzRVZYZGNoa1RKV3hQ?=
 =?iso-2022-jp?B?MGgrdnN0azNWa2pXN1diVzNHOWkzQmpVMHc5ZzQyOTBteEpIRHdaWjFW?=
 =?iso-2022-jp?B?eERFQ1laQWh3bUUzY29OYklNS3h0QUpUMjdaL2UwZGN2ZDN4R2ZCSzEv?=
 =?iso-2022-jp?B?eUJ4dWUrRmxLWXBJMzVLMmlGMlAzSDRp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?K0xqLzd2bXlBSDErNU9yMERqWUwwc3FCTE5ReHgvSUZQeGl3WkNoMkRq?=
 =?iso-2022-jp?B?djhyNzc1RkhJSjR0T2lKaVFLWFJMMy9WWE55ZmtqQ3kyMTNFSVozZDNj?=
 =?iso-2022-jp?B?SVFkbmY0N1lBSVlVM3RJdkt0Y3F0Tm9oNXpWZ0dDNDdQNlVkekZiWVo4?=
 =?iso-2022-jp?B?bzF1ZU9KalFuTzZoL1hnZndBTFRkU1BvVm83KzFYclJNckRnalhTcnp6?=
 =?iso-2022-jp?B?UCt1SWMyTG5LbXdLSnVMbkRuUGxTZFBKK05neUw2MUdDcW91Q3hla0tn?=
 =?iso-2022-jp?B?eFFKUkFieHE2WUJYOWk5YThnVjN6Mkd0VitPZTVMemFtNzFxTHdTakxN?=
 =?iso-2022-jp?B?d29YbWptQTUxb2NURFZDVURvYVBZVXRpY2ttb0EyMFAySHZ0eWduSUZL?=
 =?iso-2022-jp?B?QVRCV2RsSSs5OXpkK09JRFcvbk5oNzJSZzdpa2R5d3JBSlRLTVB6aUhw?=
 =?iso-2022-jp?B?djZJNWZXOU80Ri85Nm9CaWc0eXRaSTk5M1pYdkxiQTVleUx2ejR2Z3Qz?=
 =?iso-2022-jp?B?UlBadXFEV3NJeFp6UXJhWVROaUk2WERybStyZzdKQjU5L2l6Rm41b0Rz?=
 =?iso-2022-jp?B?RmZvTGxyVnBSQXZLQ1c3OElNaUdNMDZSazRMb3lXZXNLWWhWRXRUZ0FK?=
 =?iso-2022-jp?B?N2tVQmlVUG1pQTZERncvdHlIRm9SK3Y3Tk4wUlF6T3V3SnZ2MGhwMm50?=
 =?iso-2022-jp?B?V1FoWG9WVXlQS0V3ZzdqdnI2NUwwODFPTmxxQUtoakpqZ2c2OU5iSDJP?=
 =?iso-2022-jp?B?QkNQbnNLUDdaZDE2RjFkbmNkYnhxWlB0VFVvUGlJTHJXNXNqbDcrWnhK?=
 =?iso-2022-jp?B?Q2lXZi8vc1QyNVpOR0VPWU41RS9CeUJVOURzb3N3eDJ4ZkJhRmlCbVJ0?=
 =?iso-2022-jp?B?RkNJQUZUeHd2SEFiRC8yYWpKekdybDIzSlJnSWN3K250bTZwZmluS1dk?=
 =?iso-2022-jp?B?WVRBQ0szMjBlbTBKZG5NMnlFVkoyc3dqdWpiK2V3TG9Bc09xNFNHL1N1?=
 =?iso-2022-jp?B?ZkppYUk0eVNEZGU1N3NJdG40ajk0SWdHaDFMMVRQUm0yTHgyNmVqTStx?=
 =?iso-2022-jp?B?djl4SXh3OTJQVGtqQzkxRzJKRXhzV3lrVTFGT0hLc3pEUDN3aHNEQXJO?=
 =?iso-2022-jp?B?V3pFWU0zMmwzblFBaGJkbW80UVlqVEJQUDVPK0g0TFp4b3FmWlBDMHJn?=
 =?iso-2022-jp?B?ZndYSjYrVjE5b2Y5OTZEd2dVV3VjRStxcHlTREpqcnYzbW1oTDBhdEtE?=
 =?iso-2022-jp?B?WFFMSmthaklGTU5lNXNTeFRudk9HNlJ4UEFkQUV1a2RlZ2lOR2s4Nm5p?=
 =?iso-2022-jp?B?WE9XMFpjdG5US1VlN05FdmRBSEk1NUJIOW1FU21xOEpmS3BQMDdZL0RJ?=
 =?iso-2022-jp?B?OUVZY1pOSExoVFdhMlZSYWVnL29yaENBb1pQQUNQNWYxMjVUZW54SU1u?=
 =?iso-2022-jp?B?Q1l6U0V5RFJubzZnN1pJYlorOURqY0dRaTUwNXoxVCsyeEVQZ1Q0RUR1?=
 =?iso-2022-jp?B?SUVnN25rWmxhVUtGVk0rZ2l4Y2FaQjdjWG9raXB4YlNUVkJTaWtMdE5U?=
 =?iso-2022-jp?B?NitYNEtZcW0wMFdRT3RJV3A5cU9sWVNyeC9wQ05jMXo0YjBLci9TYS9M?=
 =?iso-2022-jp?B?a0ZpOVV2S000L2Y0SUtDN01KcVk2bVJrZnRreWVtRTZMWjRmZjNWTTZa?=
 =?iso-2022-jp?B?bGVDV0JGdktsL2ltS0JNR0gyWWJMYzkyUFFPZ0p3MzU1WlR2UmdNKzR5?=
 =?iso-2022-jp?B?U1JINDhodUxhYnZIbG5TYmtneFZpZ1RtU3ZNVC8zYkRvYWpkTmsvNkdR?=
 =?iso-2022-jp?B?NStRbUtIaG1JZUFEUjZtVENMbEZGb3RZSTFEQjNKM1B3WVJjUWczbmhB?=
 =?iso-2022-jp?B?OEdmNWdhNEp1dXlhbDB3eEpnVGRxZGpib1JJSVlrMGhMU043L0ZGVW1D?=
 =?iso-2022-jp?B?RlJCUm4rd3IrTHF4WWFDZndiTXpPUERGamlwbzBkOUpaaEg3aHpnd0lH?=
 =?iso-2022-jp?B?cFVhdmdoNm9QeHd3eklidzJ3OWw3WXVRWDh4VW5NZWRZZE1Fa3pWSTgv?=
 =?iso-2022-jp?B?cWVlc0k2VVZvcnE5S0FNQkxRVkdCR1cvcm9EUnlVWEZxUENoU3pVK1hX?=
 =?iso-2022-jp?B?VmszdjRLT0Fsb1VFZ244UmFxSVJSNjY0eExPV2daN2lPOUFlc0hUdUxQ?=
 =?iso-2022-jp?B?TkZTWWpvRlRHcHo0UW1oaUFMcjJaVnB3TnJmek96cmlhVFVCeE4vam95?=
 =?iso-2022-jp?B?RFprWkZqNkNpbi9qeXJJcHhINkpGbld4WTNKQytzOHVHZlpVSTN4QlBn?=
 =?iso-2022-jp?B?VDRVTGQvV2w5d0pid0FwWnBYMG1CSjFJRFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	949LZw0fXbUCvVI0vGpO0amtHvTJzp7bpcwGrlBVrrVDRkTkC9UDdNlI6Oz0WaU0mNkEOeKF6kQ357kjWjLQA+JYyGdJTAcm0LUg/c6xnIiz0hfiv2fdjXmAh9SeUfxodg0rykvIFBAtpPpfyOTTbcoYpqLfqn3q75bIk2RkmdufI8sHFCuZKrgfC9kwTikM2zKrixJCzm29x8oC2Ixj3EdOxnCPWCkNfz/tFi8Zm7mHNSVeznpNmUKLSocVdrviXhlbQ2cE94ZqezZtAvZHGfmt1Y1QRcLCRcNsvldSCRYF9M+jl1ILeLHfqAmgKYlXe4L0vvz79WkVanXGQOCriHsUSd36EUxzJHwHG3fJ9LRvoxcbEflY13t5jJGPv5tL5ORazT5A86EZEWyN01YL/qv0AfBTXfDfmI+4eNYztDd97KjJ3gjaJ3y0VtCd8PKadQkJb+bkYZlJGw45mIABJLhZ62ORRtuGLTqVS5Yw7yQ3UAe8XjcNTTQwwZ5v/L1BGAtaRmndY04H5IvV6PMEYNe8THScuJaxhAZV58hSnI3Lw4hz4nz0z17puveld0WX6BVGJsmnEJmm7wyqJTy8x5Tx92yLwjiOr1LWIMo9QdCiBRWlOmY76kgv0WcIVp0j
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192ada05-b4ff-49f7-8ea6-08dd7b3d668a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 10:16:19.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MajmOxA+4ne/GLWDEJU/ni0HgLiS0M25ZrMTYVy5sRT1DFeLJypRIe/jaok0YFNi8VdYbBwwz5AjYZTevSs7aiBirBJfXoKU7QLVadoI/pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6857

On Sat, April 12, 2025 2:55 AM Leon Romanovsky wrote:
> > Hi Leon,
> >
> > I have noticed the 2nd patch caused "kernel test robot" error, and you
> > kindly amended the patch. However, another error has been detected by "=
the bot"
> > because of the remaining fundamental problem that ATOMIC WRITE cannot
> > be executed on non-64-bit architectures (at least on rxe).
> >
> > I think applying the change below to the original patch(*1) will resolv=
e the issue.
> > (*1) https://lore.kernel.org/linux-rdma/20250324075649.3313968-3-matsud=
a-daisuke@fujitsu.com/
> > ```
> > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/s=
w/rxe/rxe_odp.c
> > index 02de05d759c6..ac3b3039db22 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > @@ -380,6 +380,7 @@ int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 =
iova,
> >  }
> >
> >  /* CONFIG_64BIT=3Dy */
> > +#ifdef CONFIG_64BIT
> >  enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, =
u64 value)
> >  {
> >         struct ib_umem_odp *umem_odp =3D to_ib_umem_odp(mr->umem);
> > @@ -424,3 +425,4 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe=
_mr *mr, u64 iova, u64 value)
> >
> >         return RESPST_NONE;
> >  }
> > +#endif
> > ```
> > The definition of rxe_odp_do_atomic_write() should have been guarded in=
 #ifdef CONFIG_64BIT.
> > I believe this fix can address both:
> >   - the first error "error: redefinition of 'rxe_odp_do_atomic_write' "=
 that could be caused when
> >     CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy && CONFIG_64BIT=3Dn.
> >   - the second error caused by trying to compile 64-bit codes on 32-bit=
 architectures.
> >
> > I am very sorry to bother you, but is it possible to make the modificat=
ion?
> > If I should provide a replacement patch, I will do so.
>=20
> I think that better will be simply make sure that RXE is dependent on 64b=
its.
>=20
> diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rx=
e/Kconfig
> index c180e7ebcfc5..1ed5b63f8afc 100644
> --- a/drivers/infiniband/sw/rxe/Kconfig
> +++ b/drivers/infiniband/sw/rxe/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config RDMA_RXE
>         tristate "Software RDMA over Ethernet (RoCE) driver"
> -       depends on INET && PCI && INFINIBAND
> +       depends on INET && PCI && INFINIBAND && 64BIT
>         depends on INFINIBAND_VIRT_DMA
>         select NET_UDP_TUNNEL
>         select CRC32
>=20
> WDYT?

It seems the driver is designed to be runnable on 32-bit nodes, so it may b=
e
overkill to disable 32-bit mode only for "ATOMIC WRITE" functionality.
However, I do not have strong objection to making this change if you
think it is better in terms of maintainability.

Before making the change, I'd like to get an ACK or NACK from Zhu Yanjun.
As far as I am aware, no one is actively maintaining or testing RXE on 32-b=
it,
so it may be acceptable to drop 32-bit support, but it's best to confirm be=
fore proceeding.

Thanks,
Daisuke

>=20
> Thanks
>=20
> >
> > Thanks,
> > Daisuke
> >
> > On Tue, April 8, 2025 8:12 PM Leon Romanovsky wrote:
> > > On Mon, 24 Mar 2025 16:56:47 +0900, Daisuke Matsuda wrote:
> > > > RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they canno=
t run
> > > > in the ODP mode as of now. This series is for the kernel-side enabl=
ement.
> > > >
> > > > There are also minor changes in libibverbs and pyverbs. The rdma-co=
re tests
> > > > are also added so that people can test the features.
> > > > PR: https://github.com/linux-rdma/rdma-core/pull/1580
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/2] RDMA/rxe: Enable ODP in RDMA FLUSH operation
> > >       https://git.kernel.org/rdma/rdma/c/32cad6aab9a699
> > > [2/2] RDMA/rxe: Enable ODP in ATOMIC WRITE operation
> > >       https://git.kernel.org/rdma/rdma/c/3e2746e0863f48
> > >
> > > Best regards,
> > > --
> > > Leon Romanovsky <leon@kernel.org>
> >

