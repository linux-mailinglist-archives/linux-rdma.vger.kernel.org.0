Return-Path: <linux-rdma+bounces-7511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D780A2C290
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115747A19FF
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFF91E0DE5;
	Fri,  7 Feb 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dlLhqCgc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HScfN40R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048E1D6DB5;
	Fri,  7 Feb 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930963; cv=fail; b=PD0+CHd/RouN9adkJnwfQlxoQL4G8uqDMi8ptK8yJm6dONYFMAtgS4VBAM/fTRODi3tZ2HV/ZcqKpbqXJRpA5XYUkW1rFaYJ6Erk5V4DAuEVZ49OlM/gu9/miVQm2rSd3ikfGLuWwMvQ3kWxAGXLTMqqh8Lwz8pviKdQIL4w9ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930963; c=relaxed/simple;
	bh=OKtDol+GYmu1Ib3KHZQZolPs2o8Cj43AQMvDiVO3vpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u6hHdGgyPn8oAL43U6BUawD1OKig4NkexMKC7XX1d/13FdH9EojZ/fuxtiBjn3VMP+qAUMW0JUSc+FeftWi9kr2Nf0tlrYUkAOyh2yIoYH5IRNRC2gDrOGVCLtEQ1Du2sqywKhh8cbXSWlXOkIugD6wyrugfeBMn5fGYXfdGfKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dlLhqCgc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HScfN40R; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738930961; x=1770466961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OKtDol+GYmu1Ib3KHZQZolPs2o8Cj43AQMvDiVO3vpE=;
  b=dlLhqCgcYi85SnW5IyN9pDgr1qiAMTviUIoxY2NaPWTiI8wxBE46TAga
   vD4b3qlf9UuLB4KWktLcZN+zaImQ5isesu8C72JZcL0UrJ2GgKQa0Swz2
   kmK3cBm9goe+aI9+vFVvmeYHTT86reiq1d1nTzBNwHSYQFM2mBrQ4DuTR
   gNTAprG51gKdiJQEF3717JuuBaEk9GXr8SwSKuTaGe4O9yzk5Jgg9HdW3
   Ic0JzjlB+dcayGgzwrw+Z5bV37xDFt1y8lNBW7L1n8mcGPQBfuCKLXZek
   EwxSz7kx/U0X4EijJQqByFcF1T/xglfZCMVa244aHjy1db4IaMUgsT+OZ
   A==;
X-CSE-ConnectionGUID: T+i6JeQlR7+d82wepP+dnQ==
X-CSE-MsgGUID: 43BWpqxcSZiYo5/EmFQecA==
X-IronPort-AV: E=Sophos;i="6.13,267,1732550400"; 
   d="scan'208";a="38453189"
Received: from mail-mw2nam10lp2044.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.44])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2025 20:22:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAlDf5Yyg8qbpdXr+je0Ar1fV/0EA3DxSHi7hCNYpbQ51lkPryzZ0sN3Se+TuVo8cjimFpIQBKHbA13CImNvH+TCaGJTdSeDkjW8f4XgjX4es2oDuhY1BiCjavd1QT9LKG7nJnOzliAV6d39nxBMhbBzk8kPJrjqXXRr5KBlSberAWJdG1oxBddMP5kgmEEYqk6pPWBtJma2DZdTMB42qZkJSuQcOexPr3w3X2f+IBT3q6lcyOGZIw/gOAzMA7SftdidXVSCuKYD/V8vkHAHcEQpOmNR4RwETNFl/D/JWzhuYnqINUcRqm1YB3EdlyTLzulZhOYLSgBvtbHv9LlTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY+nV7lTTtmnJ3VeP4aC0E8+4kNsTuGZ8uK/oCTg7VA=;
 b=tRjZmw6aqIsWrLu8vL16sN8o0Oov8usqaypZx/AhBe+XOwo0RPbhst/hZxzcy+4GePNaZuNT1whqDwLZpSswiH6loM1sEwWj2xD+TZltuU05WhmDf5mJEsj4cUd8J0NO6osxirfYnVvlmGmSruBOf+HJyA9QITQ4Za7TSO0N25mHHOFrgbk0HoGFPi+t9dkOEoXH1JRzX5Cq0g+pppxheJhNTq5r5+W2G+X8EUBdOpVD+udNWp4lAELpcghv9BSKXtUpPKLzzhzf7Aibi1PUqDShc1zanou6Ew0T1T77CjSu7RsUiSEvfiRpxf0qK/OgI4F6UQjQulb6rxCXjhgRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY+nV7lTTtmnJ3VeP4aC0E8+4kNsTuGZ8uK/oCTg7VA=;
 b=HScfN40RqYdKBumraasNhP12jZSpruHvAGF2nTG66tM3GSJ4PfWOvakKVHErILdkJ7ianWR6CLvNCK66r/WZw5tQBVSQFwCr8BLpNHu1ltoSREo8kP/Ed0EsPjvUR0vRQz97bpCP3j3Ga95VAcx5fCWQE11a/06J8Qx5Gun9UNQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8033.namprd04.prod.outlook.com (2603:10b6:610:fe::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Fri, 7 Feb 2025 12:22:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 12:22:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.14-rc1 kernel
Thread-Topic: blktests failures with v6.14-rc1 kernel
Thread-Index: AQHbeP78AGAfwR9brEG+YzS4r+evebM7iSUAgAA6x4A=
Date: Fri, 7 Feb 2025 12:22:32 +0000
Message-ID: <ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs>
References: <uyijd3ufbrfbiyyaajvhyhdyytssubekvymzgyiqjqmkh33cmi@ksqjpewsqlvw>
 <Z6XJuIz012XATr7h@fedora>
In-Reply-To: <Z6XJuIz012XATr7h@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8033:EE_
x-ms-office365-filtering-correlation-id: d95600df-c348-4eae-38d2-08dd477218a3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eYxz+oOu/YmS8msw92A/x0xrTcu9lnvzYev4w4JC51jMNSc6/Vnt7Zhm8qOp?=
 =?us-ascii?Q?qd/JQX7FgidmJgMwd44ecI7dfIJcU29/s8U4J8GwsVxGC+uSvxvEaeGp0wLV?=
 =?us-ascii?Q?2WLxbW3eCM5bIH4KdbBhXIPeHtWq9bE9bqr8mUexcAAty4MojoGds0uFrh2f?=
 =?us-ascii?Q?g0ukbjW/WGLNo281UNu+UwFqSbrX9fI10GKk/9VNO9LswezoHVFGo//fsW6/?=
 =?us-ascii?Q?rmv9U3/eHLsol3LuilMaDj9spRVqmD6xefwRTvMkMyqKPwelLsLgfRTRkpYc?=
 =?us-ascii?Q?fTjqpWhW54VEFQM+IJ9mL2QgBQOtDBD60ciBfxDJ5KPlGAD9aiOQ9K8v3V8A?=
 =?us-ascii?Q?8Hxe0EuPcoUyjus0uZZiD9i8EAYhbnr1AIUnyd8gtuEy6HzP54XnLtqkQgNn?=
 =?us-ascii?Q?op4UVk3tlVYPyx/d2gB60OfC1Sd56UfdeIkwO/tI+I0n+lSueDdpx2LNcRek?=
 =?us-ascii?Q?Z1uOn7rSBt5y61PHeINUry9+RVLBwMeMtohR9S48z/0Y5MhRnhPBGh7FbFi+?=
 =?us-ascii?Q?7EcUZULg7VkTr9n8EIyNANAD7+ktFewfsOPPuAO9aD5w3zujQy4/7kggGs9s?=
 =?us-ascii?Q?1+7s2/FQkomMTfsBKo47twJCxVlX4+tfbKwMmXpbnz6owIs9o2GkW2xIloYC?=
 =?us-ascii?Q?7l837p3vAtgdeMIeU+PXdWM3F1ygX09bIkjxlaH33f/rv6RIGf75p8nzREFu?=
 =?us-ascii?Q?uhdGX38WfSiGusO/Ojumqx8xkyG/f9BKprjhoHZJO42zR+JQ5NzcbWA6mkZv?=
 =?us-ascii?Q?q8aWADi0xeqggxw8sDrHRek8VMBDiLRbH6DSLQn9u4IrXDgIV7Vnq+GUpuDk?=
 =?us-ascii?Q?4d5wF7bkKTa/jvyGeTHpm+/THkY8n2lxbpeRw2+/lqTwXKnp7f5Pg+FA5aqI?=
 =?us-ascii?Q?tkeQOmaNoVayWWUoOmhH/6rSiTTV6Q6c9BX776unLOEBA6cKqqUtVL8SasnU?=
 =?us-ascii?Q?h/bgiRmdW56Kua7Q53RJSc9gxXVW0aRtZ10ryk4c8bd8J9bZFjTYe9AKvreh?=
 =?us-ascii?Q?WVskeJk7rzVl8h9wbnQagpgmiubRBgKVtdWAQaHygSqRsj9amPeovN2XzyvL?=
 =?us-ascii?Q?MjZ46EHEMDxi8LrVLj1g2jhrO2Ts1ZrCFZSHAtB3kLLT3vP3PX31B0EiQaER?=
 =?us-ascii?Q?1kJyTQ0mFcK/GXg9qFYqmhf+jJh+Yec5CgTZTa0z6oeVNrclcshyRupDfsNw?=
 =?us-ascii?Q?LLoXuug2tPLleWa/OkXRSX5/hMCcidhMSMjt1Qf+OBSa2TUDNlyHF1LhaaZ8?=
 =?us-ascii?Q?XVVAiGL58r/oziBE9EXbFPRY0VrQBHcvBzCv4oqqgz2gsg4NH7GylRh4IYcD?=
 =?us-ascii?Q?szGnkR9FcwUoJXGVn4nIfxCb7GhGMEYZ2CmN7A2Y7AKuUNoYFZTJZ46kmWKf?=
 =?us-ascii?Q?7mk6R1y41NSdB2/YROrhd7+iNChIzHTXb83HfbBRv9mFxgYlFnUqvjYlGDhJ?=
 =?us-ascii?Q?B9NxyU6NcDdNN3tx+cdLrfzLAUta7GW+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ymD+s+2vV5yjQRSFCbrVhfhZXwlVv2VgE8zLKLrEfWs/S3v5YvvVeia8KZtp?=
 =?us-ascii?Q?TPcYTDr5VX415hEwftSudp3dUmut9D2dFVkedkyrcpnl8ut3pk+pBy7lOLHN?=
 =?us-ascii?Q?D8k8yNB8gdcfBhJWrWsAkjB6OVEGNvfrDWWZFzHPF5ZIxIyfDtnDp7yJMiRl?=
 =?us-ascii?Q?Zpg4yKhF0JkJkhr6boFZA7qaQ2XhG7Sb8QQMhd19i55VnZ+1Dv+kHkniHGlK?=
 =?us-ascii?Q?b4+zYWVNJv9vKpnWFrHJCMPfgjPJ2Od6ywj9MqNZW1Y15rmeRdXuPK+79NxY?=
 =?us-ascii?Q?JATGwrDLF4M7PtIo5vNe8yFhg3pwOOWKNOHRUaZVsIq/vtdwcPawBDrLiQ+5?=
 =?us-ascii?Q?Z+jL3JV9e6aHAPTxU7arJ72BgDpju0pCfhGTIonl7WI5CjaMglNo58P91fQG?=
 =?us-ascii?Q?nK1ir4i0ynPat7JQv7JjdBz1oFOQym1lddm+LYSpt7sFb5iMp3Yc2Tgdy0FS?=
 =?us-ascii?Q?JTQ8r6D8BEG3XQD3T93Lr+5OZQvOWOB15drFLUPiOypwZu45siT4WmrLWWfC?=
 =?us-ascii?Q?3ELLVrspe+reDw9uLUPAu0h12OJ51Q22ysFMCQQzvvbC4KOB43FMx0YyGm6M?=
 =?us-ascii?Q?r83EN0xim0dn0YR5BZ/VfVqtGT3u8VoeTongk+tgUuR77ZZdUnjpxt/++Ip7?=
 =?us-ascii?Q?iz0w6LcZJMo6CMn13huNGFlndbBhvnASPSkNewXn3p50soTbq60kOYRCHXCr?=
 =?us-ascii?Q?zTtDbdGVoIsQYa0ay6Zz9rwO5q0OuI5oFamq9n33v6MgIzbOOu1cTECyXSkt?=
 =?us-ascii?Q?wVhKAsNcS+EqC1v/i6qJDfBLn5ktQUMx4dgvy6xbCj0YfxOtI04UzabiWYRP?=
 =?us-ascii?Q?9wn4TigDFKBAplRQdCFnXf057H1Ks3LEgxysJlff4mP245TYTtFCyd92MA2o?=
 =?us-ascii?Q?zogwm0k04zqasyJvsGn8oGo0YUXuK7pVzjCkgzETTSJ4dRHOfqVKf5kLH+WR?=
 =?us-ascii?Q?n9ACmMZWoUJpApzo5WoQ0PdZHJpFc1Y3SaemK+Z/3bpPDwe6kz4kECs+3ZWq?=
 =?us-ascii?Q?mM+ziW7S6KOaHAuM3k1P7LwdPXpEbgFCWJENyP17ZxZnWPA2VR4x8DTPACvL?=
 =?us-ascii?Q?vV957cx0teBkXser9RQhe+0jCYB9GGhlAGjqzCpaXiRFph5P45R1/jcB+hDO?=
 =?us-ascii?Q?ZFxOzMxWxCt8k7u2Jou+K6JWPDamtzQrAllsCoCk2JCinbGMJtyqMF4WQrTd?=
 =?us-ascii?Q?L5/aDBc2c73nsPF55N4fWJ02S9wyjf2PSPMc0JwCIxuFDnkxaheEnovWcKIf?=
 =?us-ascii?Q?UiqE3OD7EH8oVvSBs7SpScJoGrzgoG4BHpiqHp7ZkqO94ZNMdycx0aaQ3PHy?=
 =?us-ascii?Q?4wnACYD/G7ZTnsS0ePOiMz+LJUIBxYtqPb9xGBfszVPnfcKnJ9881GYtP2rZ?=
 =?us-ascii?Q?TJaRikFKtOHFbiWRNIBFHb3jNKdkvHNi9kxbH8qwmOhobRNylsZbgOSrtHpD?=
 =?us-ascii?Q?oRFtoTKcRpNJgdvToJGbz3PlzbANMVBdmCDtWmncjcGZjEA913QHhgHL2/iV?=
 =?us-ascii?Q?GsCsHcdCe5SHLM3Y4ULqQphWYq5UaqK1uN2WtsS0wPFEB7C4dlCNsX/XU6Vu?=
 =?us-ascii?Q?itNhf0Yda/PF4TMYaUNeT3HBxAFJL0rc4QxhyAW9MNb+/qd+yCQ2YnTg0dkd?=
 =?us-ascii?Q?o7kZZNWsOHCoJwUJY6Qd65o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9385DAA6D788B34DB08BC088C9A3D3EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yz8viY4tj1Gu8O7avvoZ3xkmlyw935P1VFUoElX8OUiwZqOLB7NK2ZLdaK/GUpwSXO5wwj5sZ8qy9Ts0o6awmSZg/Q0Dn0pLJjyuv4tTdfS6UR7UDvWsDpvJPrPBCwfdjEHESKpo6zzz24ZuTrjdiIkvhuA12AvRMYHIjxOpxKffJnHMxTtzbVNWg0Vtz0W3HY0d+hw8WvO1AWt12u99bA6WmBDE+LX+tbZjemBbX4e5qYm7101iX4sfdc+Et2nJ27MpGRTthmSL3m6t4HIxU2bqidRDY6Kx2C427U/CfNNNCcIOu8sBIKvLluhUQpBbNWmGy/G51lY1PyQrVcOQg0OOOnyyEjRGdKUz1WVZteg+JazDIjqnGBUKOrELsOlzA80frZSDyRLrrKeHAzdEeOBRiYhgyn9Ffrud7DfBdfT9OWsoiQU8UPjBQiqJdZw5WfzCeimQClolG5wMzbok8hD+5/liqa+ISCU8CBABvBg7EcuRuMPg/IckW23BGflxGPkOVGP7GTlWDqXPHJLYrGRb80ikcC9uYvXgSs2KQHi/zqgPH/whHGaCgTt7tcrWZQywTgFilDGfwRXwWKhJESeAbgnFYrCOryIXplfmruQ7Aj9X7QvTaFybX8TVcC41
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95600df-c348-4eae-38d2-08dd477218a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 12:22:32.1518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtAouQnC8ud1niB8XraXh//XNdbeVJT50eHtrpVSY4JxlZB4wq2Fr1M6NMl4OxxjIhP8QpwuphdOuZcDaZXJfdM4cJxs3zKzM+/jWbPtq5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8033

On Feb 07, 2025 / 16:52, Ming Lei wrote:
> Hi Shinichiro,

Hi Ming, thanks for the comments. Let me comment on the block/002 failure.

> > Failure description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > #1: block/002
> >=20
> >     This test case fails with a lockdep WARN "possible circular locking
> >     dependency detected". The lockdep splats shows q->q_usage_counter a=
s one
> >     of the involved locks. It was observed with the v6.13-rc2 kernel [2=
], and
> >     still observed with v6.14-rc1 kernel. It needs further debug.
> >=20
> >     [2] https://lore.kernel.org/linux-block/qskveo3it6rqag4xyleobe5azpx=
u6tekihao4qpdopvk44una2@y4lkoe6y3d6z/
>=20
> [  342.568086][ T1023] -> #0 (&mm->mmap_lock){++++}-{4:4}:
> [  342.569658][ T1023]        __lock_acquire+0x2e8b/0x6010
> [  342.570577][ T1023]        lock_acquire+0x1b1/0x540
> [  342.571463][ T1023]        __might_fault+0xb9/0x120
> [  342.572338][ T1023]        _copy_from_user+0x34/0xa0
> [  342.573231][ T1023]        __blk_trace_setup+0xa0/0x140
> [  342.574129][ T1023]        blk_trace_ioctl+0x14e/0x270
> [  342.575033][ T1023]        blkdev_ioctl+0x38f/0x5c0
> [  342.575919][ T1023]        __x64_sys_ioctl+0x130/0x190
> [  342.576824][ T1023]        do_syscall_64+0x93/0x180
> [  342.577714][ T1023]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> The above dependency between ->mmap_lock and ->debugfs_mutex has been cut=
 by
> commit b769a2f409e7 ("blktrace: move copy_[to|from]_user() out of ->debug=
fs_lock"),
> so I'd suggest to double check this one.

Thanks. I missed the fix. Said that, I do still see the lockdep WARN "possi=
ble
circular locking dependency detected" with the kernel v6.14-rc1. Then I gue=
ss
there are two problems and I confused them. One problem was fixed by the co=
mmit
b769a2f409e7, and the other problem that I still observe.

Please take a look in the kernel message below, which was observed at the
block/002 failure I have just recreated on my test node. The splat indicate=
s the
dependency different from that observed with v6.13-rc2 kernel.


[  165.526908] [   T1103] run blktests block/002 at 2025-02-07 21:02:22
[  165.814157] [   T1134] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
[  166.031013] [   T1135] scsi_debug:sdebug_driver_probe: scsi_debug: trim =
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[  166.031986] [   T1135] scsi host9: scsi_debug: version 0191 [20210520]
                            dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1,=
 statistics=3D0
[  166.035727] [   T1135] scsi 9:0:0:0: Direct-Access     Linux    scsi_deb=
ug       0191 PQ: 0 ANSI: 7
[  166.038449] [      C1] scsi 9:0:0:0: Power-on or device reset occurred
[  166.045105] [   T1135] sd 9:0:0:0: Attached scsi generic sg3 type 0
[  166.046426] [     T94] sd 9:0:0:0: [sdd] 16384 512-byte logical blocks: =
(8.39 MB/8.00 MiB)
[  166.048275] [     T94] sd 9:0:0:0: [sdd] Write Protect is off
[  166.048854] [     T94] sd 9:0:0:0: [sdd] Mode Sense: 73 00 10 08
[  166.051019] [     T94] sd 9:0:0:0: [sdd] Write cache: enabled, read cach=
e: enabled, supports DPO and FUA
[  166.059601] [     T94] sd 9:0:0:0: [sdd] permanent stream count =3D 5
[  166.063623] [     T94] sd 9:0:0:0: [sdd] Preferred minimum I/O size 512 =
bytes
[  166.064329] [     T94] sd 9:0:0:0: [sdd] Optimal transfer size 524288 by=
tes
[  166.094781] [     T94] sd 9:0:0:0: [sdd] Attached SCSI disk

[  166.855819] [   T1161] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  166.856339] [   T1161] WARNING: possible circular locking dependency det=
ected
[  166.856945] [   T1161] 6.14.0-rc1 #252 Not tainted
[  166.857292] [   T1161] -------------------------------------------------=
-----
[  166.857874] [   T1161] blktrace/1161 is trying to acquire lock:
[  166.858310] [   T1161] ffff88811dbfe5e0 (&mm->mmap_lock){++++}-{4:4}, at=
: __might_fault+0x99/0x120
[  166.859053] [   T1161]=20
                          but task is already holding lock:
[  166.859593] [   T1161] ffff8881082a1078 (&sb->s_type->i_mutex_key#3){+++=
+}-{4:4}, at: relay_file_read+0xa3/0x8a0
[  166.860410] [   T1161]=20
                          which lock already depends on the new lock.

[  166.861269] [   T1161]=20
                          the existing dependency chain (in reverse order) =
is:
[  166.863693] [   T1161]=20
                          -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
[  166.866064] [   T1161]        down_write+0x8d/0x200
[  166.867266] [   T1161]        start_creating.part.0+0x82/0x230
[  166.868544] [   T1161]        debugfs_create_dir+0x3a/0x4c0
[  166.869797] [   T1161]        blk_register_queue+0x12d/0x430
[  166.870986] [   T1161]        add_disk_fwnode+0x6b1/0x1010
[  166.872144] [   T1161]        sd_probe+0x94e/0xf30
[  166.873262] [   T1161]        really_probe+0x1e3/0x8a0
[  166.874372] [   T1161]        __driver_probe_device+0x18c/0x370
[  166.875544] [   T1161]        driver_probe_device+0x4a/0x120
[  166.876715] [   T1161]        __device_attach_driver+0x15e/0x270
[  166.877890] [   T1161]        bus_for_each_drv+0x114/0x1a0
[  166.878999] [   T1161]        __device_attach_async_helper+0x19c/0x240
[  166.880180] [   T1161]        async_run_entry_fn+0x96/0x4f0
[  166.881312] [   T1161]        process_one_work+0x85a/0x1460
[  166.882411] [   T1161]        worker_thread+0x5e2/0xfc0
[  166.883483] [   T1161]        kthread+0x39d/0x750
[  166.884548] [   T1161]        ret_from_fork+0x30/0x70
[  166.885629] [   T1161]        ret_from_fork_asm+0x1a/0x30
[  166.886728] [   T1161]=20
                          -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
[  166.888799] [   T1161]        __mutex_lock+0x1aa/0x1360
[  166.889863] [   T1161]        blk_mq_init_sched+0x3b5/0x5e0
[  166.890907] [   T1161]        elevator_switch+0x149/0x4b0
[  166.891928] [   T1161]        elv_iosched_store+0x29f/0x380
[  166.892966] [   T1161]        queue_attr_store+0x313/0x480
[  166.893976] [   T1161]        kernfs_fop_write_iter+0x39e/0x5a0
[  166.895012] [   T1161]        vfs_write+0x5f9/0xe90
[  166.895970] [   T1161]        ksys_write+0xf6/0x1c0
[  166.896931] [   T1161]        do_syscall_64+0x93/0x180
[  166.897886] [   T1161]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  166.898945] [   T1161]=20
                          -> #3 (&q->q_usage_counter(io)#2){++++}-{0:0}:
[  166.900757] [   T1161]        blk_mq_submit_bio+0x19b8/0x2070
[  166.901784] [   T1161]        __submit_bio+0x36b/0x6d0
[  166.902748] [   T1161]        submit_bio_noacct_nocheck+0x542/0xca0
[  166.903796] [   T1161]        iomap_readahead+0x4c4/0x7e0
[  166.904778] [   T1161]        read_pages+0x198/0xaf0
[  166.905718] [   T1161]        page_cache_ra_order+0x4d3/0xb50
[  166.906709] [   T1161]        filemap_get_pages+0x2c7/0x1850
[  166.907684] [   T1161]        filemap_read+0x31d/0xc30
[  166.908617] [   T1161]        xfs_file_buffered_read+0x1e9/0x2a0 [xfs]
[  166.909910] [   T1161]        xfs_file_read_iter+0x25f/0x4a0 [xfs]
[  166.911131] [   T1161]        vfs_read+0x6bc/0xa20
[  166.911994] [   T1161]        ksys_read+0xf6/0x1c0
[  166.912862] [   T1161]        do_syscall_64+0x93/0x180
[  166.913736] [   T1161]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  166.914751] [   T1161]=20
                          -> #2 (mapping.invalidate_lock#2){++++}-{4:4}:
[  166.916401] [   T1161]        down_read+0x9b/0x470
[  166.917285] [   T1161]        filemap_fault+0x231/0x2ac0
[  166.918179] [   T1161]        __do_fault+0xf4/0x5d0
[  166.919039] [   T1161]        do_fault+0x965/0x11d0
[  166.919895] [   T1161]        __handle_mm_fault+0x1060/0x1f40
[  166.920829] [   T1161]        handle_mm_fault+0x21a/0x6b0
[  166.921722] [   T1161]        do_user_addr_fault+0x322/0xaa0
[  166.922648] [   T1161]        exc_page_fault+0x7a/0x110
[  166.923540] [   T1161]        asm_exc_page_fault+0x22/0x30
[  166.924466] [   T1161]=20
                          -> #1 (&vma->vm_lock->lock){++++}-{4:4}:
[  166.926085] [   T1161]        down_write+0x8d/0x200
[  166.926943] [   T1161]        vma_link+0x1ff/0x590
[  166.927794] [   T1161]        insert_vm_struct+0x15a/0x340
[  166.928713] [   T1161]        alloc_bprm+0x626/0xbf0
[  166.929578] [   T1161]        kernel_execve+0x85/0x2f0
[  166.930476] [   T1161]        call_usermodehelper_exec_async+0x21b/0x430
[  166.931481] [   T1161]        ret_from_fork+0x30/0x70
[  166.932371] [   T1161]        ret_from_fork_asm+0x1a/0x30
[  166.933291] [   T1161]=20
                          -> #0 (&mm->mmap_lock){++++}-{4:4}:
[  166.934868] [   T1161]        __lock_acquire+0x2f52/0x5ea0
[  166.935768] [   T1161]        lock_acquire+0x1b1/0x540
[  166.936678] [   T1161]        __might_fault+0xb9/0x120
[  166.937563] [   T1161]        _copy_to_user+0x1e/0x80
[  166.938438] [   T1161]        relay_file_read+0x149/0x8a0
[  166.939343] [   T1161]        full_proxy_read+0x110/0x1d0
[  166.940224] [   T1161]        vfs_read+0x1bb/0xa20
[  166.941082] [   T1161]        ksys_read+0xf6/0x1c0
[  166.941920] [   T1161]        do_syscall_64+0x93/0x180
[  166.942780] [   T1161]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  166.943755] [   T1161]=20
                          other info that might help us debug this:

[  166.945985] [   T1161] Chain exists of:
                            &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s=
_type->i_mutex_key#3

[  166.948504] [   T1161]  Possible unsafe locking scenario:

[  166.950078] [   T1161]        CPU0                    CPU1
[  166.950965] [   T1161]        ----                    ----
[  166.951849] [   T1161]   lock(&sb->s_type->i_mutex_key#3);
[  166.952751] [   T1161]                                lock(&q->debugfs_m=
utex);
[  166.953789] [   T1161]                                lock(&sb->s_type->=
i_mutex_key#3);
[  166.954860] [   T1161]   rlock(&mm->mmap_lock);
[  166.955689] [   T1161]=20
                           *** DEADLOCK ***

[  166.957776] [   T1161] 2 locks held by blktrace/1161:
[  166.958623] [   T1161]  #0: ffff88813c9ebcf8 (&f->f_pos_lock){+.+.}-{4:4=
}, at: fdget_pos+0x233/0x2f0
[  166.959808] [   T1161]  #1: ffff8881082a1078 (&sb->s_type->i_mutex_key#3=
){++++}-{4:4}, at: relay_file_read+0xa3/0x8a0
[  166.961118] [   T1161]=20
                          stack backtrace:
[  166.962578] [   T1161] CPU: 2 UID: 0 PID: 1161 Comm: blktrace Not tainte=
d 6.14.0-rc1 #252
[  166.962582] [   T1161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[  166.962585] [   T1161] Call Trace:
[  166.962586] [   T1161]  <TASK>
p[  166.962588] [   T1161]  dump_stack_lvl+0x6a/0x90
[  166.962593] [   T1161]  print_circular_bug.cold+0x1e0/0x274
[  166.962597] [   T1161]  check_noncircular+0x306/0x3f0
[  166.962600] [   T1161]  ? __pfx_check_noncircular+0x10/0x10
[  166.962605] [   T1161]  ? lockdep_lock+0xca/0x1c0
[  166.962607] [   T1161]  ? __pfx_lockdep_lock+0x10/0x10
[  166.962611] [   T1161]  __lock_acquire+0x2f52/0x5ea0
[  166.962616] [   T1161]  ? __pfx___lock_acquire+0x10/0x10
[  166.962619] [   T1161]  ? lock_acquire+0x1b1/0x540
[  166.962623] [   T1161]  lock_acquire+0x1b1/0x540
[  166.962625] [   T1161]  ? __might_fault+0x99/0x120
[  166.962628] [   T1161]  ? __pfx_lock_acquire+0x10/0x10
[  166.962631] [   T1161]  ? lock_is_held_type+0xd5/0x130
[  166.962635] [   T1161]  ? __pfx___might_resched+0x10/0x10
[  166.962637] [   T1161]  ? _raw_spin_unlock+0x29/0x50
[  166.962640] [   T1161]  ? __might_fault+0x99/0x120
[  166.962642] [   T1161]  __might_fault+0xb9/0x120
[  166.962649] [   T1161]  ? __might_fault+0x99/0x120
[  166.962651] [   T1161]  ? __check_object_size+0x3f3/0x540
[  166.962654] [   T1161]  _copy_to_user+0x1e/0x80
[  166.962656] [   T1161]  relay_file_read+0x149/0x8a0
[  166.962661] [   T1161]  ? selinux_file_permission+0x36d/0x420
[  166.962665] [   T1161]  full_proxy_read+0x110/0x1d0
[  166.962667] [   T1161]  ? rw_verify_area+0x2f7/0x520
[  166.962670] [   T1161]  vfs_read+0x1bb/0xa20
[  166.962672] [   T1161]  ? __pfx___mutex_lock+0x10/0x10
[  166.962674] [   T1161]  ? __pfx_lock_release+0x10/0x10
[  166.962677] [   T1161]  ? __pfx_vfs_read+0x10/0x10
[  166.962683] [   T1161]  ? __fget_files+0x1ae/0x2e0
[  166.962687] [   T1161]  ksys_read+0xf6/0x1c0
[  166.962689] [   T1161]  ? __pfx_ksys_read+0x10/0x10
[  166.962693] [   T1161]  do_syscall_64+0x93/0x180
[  166.962697] [   T1161]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  166.962700] [   T1161]  ? do_syscall_64+0x9f/0x180
[  166.962702] [   T1161]  ? lockdep_hardirqs_on+0x78/0x100
[  166.962704] [   T1161]  ? do_syscall_64+0x9f/0x180
[  166.962708] [   T1161]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[  166.962711] [   T1161]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  166.962714] [   T1161] RIP: 0033:0x7fdddfde0e4a
[  166.962719] [   T1161] Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 7=
5 f0 89 7d f8 e8 28 58 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c=
0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 82 58 f8 ff 48 8b
[  166.962721] [   T1161] RSP: 002b:00007fdddecccd80 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[  166.962726] [   T1161] RAX: ffffffffffffffda RBX: 00007fddd4000bb0 RCX: =
00007fdddfde0e4a
[  166.962727] [   T1161] RDX: 0000000000080000 RSI: 00007fdddc400000 RDI: =
0000000000000006
[  166.962729] [   T1161] RBP: 00007fdddecccda0 R08: 0000000000000000 R09: =
0000000000000000
[  166.962730] [   T1161] R10: 0000000000000001 R11: 0000000000000246 R12: =
0000000000000000
[  166.962731] [   T1161] R13: 000056530426caa0 R14: 0000000000000000 R15: =
00007fddd4002c90
[  166.962735] [   T1161]  </TASK>
[  167.066759] [   T1103] sd 9:0:0:0: [sdd] Synchronizing SCSI cache=

