Return-Path: <linux-rdma+bounces-1895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3C8A071E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 06:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8246E1F242EC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 04:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EBD13C3CC;
	Thu, 11 Apr 2024 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gc65xmc2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5D13BC33;
	Thu, 11 Apr 2024 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809101; cv=fail; b=bi5Vu9fxAzqfCx1IH8fTzRA1UWLiVmrzm+2OjwkvYkWmtBnRa/mJsc/DtrXxt5YBKl15hUxujATVjhJvdpMvMC6olL9AxqB3zhc2OXuLii33b34JrYV24MlfFqN39uAOi5yTzq6RPM1lpQckS7GU1FxJWnJXh7Vhv6AfoYWRJNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809101; c=relaxed/simple;
	bh=mNPECGNwf4D0mV2YAZfenYtxieu75Nip/tbaj5vdgSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIMGILqPBBeMNeBWnMONba/uGDeaOfdTFAkSeZnOBYJu5UP1YhG0uMksBVjH5xqaL+BpcopSvytNXhFWnwPWIW2ZTLXCvPPo3/5i2dV7dRKaPCIOSsoAKEKMH+5p1fZ+U5mkrj1yR0Fx7VeQQbYkFmjzjdFLuv5I5rJX+4IETLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Gc65xmc2; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSuTRZFJI3VVGVVVeTDrPpEkFHYsYaydj+SBo4cu/duEKOrPt2zrP5rf3Jwyl0ZcKZqPsnhCwMvLIIFD9wcbgNf5XCiCvrAYQbsdIEgIFbsErfnIBDR8gr9rYgfA+uOXGt5nneqxP5AkQKRLBOLbaBQ+y60Jge+ne1gjtQHqwsZlws8w/xpGJTWuSB0ZtjVVRZOZJV9Ip7HkWwaiDfbXV7yIsKShKL8zQTo3l+JWg42rEciiQ/4tfKdDW14qgwbobvFFIbg38chrhwvr/dcClzHjEYTdSEM4PtuUE9GciZDa999/q9G8eyjuG930o7C3lhcXLVGxvOFq0nJrZMIzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNPECGNwf4D0mV2YAZfenYtxieu75Nip/tbaj5vdgSI=;
 b=ck6nHL8MjHgGpGnsvbm/RE/+KCRPzARJfRxDgIcDT9aPEUM1CqlPSVhcV0c2yC2yhU3LwLNdJoqYlENnqqdqfxeRs9eBY5y5T1hgymqEf5FJScbJ9Q8jCQ4A/vWrRVAFvYvQNF1Qg9nc9GiCXhz7A8hvg3Bq2CCGAAxMNE5HsBtQP4FR8wMkNB5QwV3+N0GOwxKoOVVfR8LpErcSz85YSC+SPyR1nEzALYczMvtWrzLL2P68SWzDrRqxfpegm+BNg+Pdf0ETuVbOKJrjFSmSIV9Wuu5IGHXa71cUwgOxRrUr02PzkbSdXU1DOxy50MXF/vmuO2y43wB1ez0cMbMrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNPECGNwf4D0mV2YAZfenYtxieu75Nip/tbaj5vdgSI=;
 b=Gc65xmc2rybO/Clk59ktprg36dsVsUCc/MCSBZehNLNcFbQ2Jwd3nDEQuf2mYn8mP8F/Ja5KBhROW7FIrm/LTkGTX10H5SdHCjKL5tfTD+qaaO0OplSZkF/rzYBToBHhZQRNlmD7pgl8usXd8plofoRWSrDvcBqtmS1PtqycWb4=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by PH0PR21MB2048.namprd21.prod.outlook.com (2603:10b6:510:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.11; Thu, 11 Apr
 2024 04:18:15 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7472.007; Thu, 11 Apr 2024
 04:18:15 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: remove useless return values
 from dbg prints
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: remove useless return values
 from dbg prints
Thread-Index: AQHaiokvhuaZ+Um/4U+tDjbSGaLo7LFieUhA
Date: Thu, 11 Apr 2024 04:18:15 +0000
Message-ID:
 <SJ1PR21MB3457025320C3524B191B7099CE052@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1712672465-29960-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1712672465-29960-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bd4917a8-2112-44be-a548-deb0b2f59e29;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-11T04:17:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|PH0PR21MB2048:EE_
x-ms-office365-filtering-correlation-id: 50730702-d566-4050-c90e-08dc59de68d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WcdLvniw3MGOfIy5gncgNjT2O+L2c+rziDIyq/ujOuoeiEzGaOrWT0/PjsanjjRDNczicB3VZips3m0mt/T1Z1wmksoPXS+cwgqsmNBVKw1wdiaYSwo++NTiVCN/xmKliQmu7ytmm37BJ950anSdRVAWfVgmAHhq3uGe4MWQ/G9PNO67ySXN/h3isyPtpPST1eOhyssMGQHB4u+jBbv6My9q0XQu+ZgMTMJtFnG4zVz5Au7CO0amPadR+pWpR/uG8cHnJAfj/3VinyyNUZVh9R+RtwQRf5bk0GvHdZkBcnw1XnGho96ven6R7oWigq/Seff5R/JQtdKzLPa+yEOYCFELBc2WzZKkWlAq5Hgwz+eYobtCFvdzrXGwtiip8cJLAp21GpxZlbW1rOVEaLaHNbJigXkrUEonbf1uRp4Tc+8BH60SNGBOj7k6k0wR7d8P/5iOhn5/vSsBzDTL/47jEX1mdJYnXw8lfiA/bwCt9L1i6whURxUKPvEWFVrNEOzLfB1Pk6KYfk9Ip8/t5YxaowIIyY33+U+XTnsfN+4/vXDtu1lRunNgTJAMf7pkmb7yTgmd8moqrQ9n5j10zdTDTuzHzIzQmme5rxmCB2LMQKwmchnwxm/AAibiX0GoSJT1PhPipig6fUstaShd45C+jLeTMQEwhhzjDGvW/Z4/3XSZmczQW1t7tH6mMfYlHvpNBSHChbqK8ebYrDn8Ri/OfIg5sF3r97dcD9yAMn/E33c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6vi9s/ow69Cfi3Wuzl/7itkDqq+X7DALPwhlzYdPSyyzrE9n8mcHkv+fcYUZ?=
 =?us-ascii?Q?XcbLOyOTN2GMY3p8NT1eYqVCaZwx9/nm4RGJWYNKj5LRlkrEKsIICUuGq4Bo?=
 =?us-ascii?Q?w/ScHi7roESZrmDL53S8Vt4VvgCbHCNMQlWa7aDbbdoHirnl+aGp1iBSiOlK?=
 =?us-ascii?Q?qyM67AbZjN/DjyDnMpN8J8Cu2JjtW3l5nGJ5Ka3sU8ezYjLwru0hTp59qQ8N?=
 =?us-ascii?Q?uMAElJ6SfbQXa6C8fFWRNnvEEv3C7r9T3wce9jM5+n3598zoHD4oJXhzmUXj?=
 =?us-ascii?Q?bbcWOEx728ZH8eqgfdUlqEfxaezLXx/z32lkEoNjcXylVsUCIpWRZS1SwpRD?=
 =?us-ascii?Q?3Nb+H0ZsV4QNZClCVrHo2vAEzaVpUjjmkjaPq+TY9GLtFUDJ+1gPOfLeJM8g?=
 =?us-ascii?Q?MdEw+kvJdTITLAgGvJqNy1zHdWuisZtCSFKFcIl1/PLgzbl1jN4VKYj3RfwE?=
 =?us-ascii?Q?JPW2HEZZ3/AA+C8QMdaVR5DOnf1DCcWe8Slj1vycu2Wk7LHmLco1K79VzJL4?=
 =?us-ascii?Q?JAJLw8T5AqMHocJPO4oT+I1rAv+4nXTh7e1xXoQ9GtOqchpRVi8bs+jYaM06?=
 =?us-ascii?Q?FGQD5JQX0opCw+Bd0x6ZCrygA/krDfuhKH5D38QbsDsWvfmEtzaN0kbNtYHJ?=
 =?us-ascii?Q?z+2Iz9QclOkBEqBPnAy2umYG02Z+NhQ9FhR5XW/5sF7yZBwXBOvnLv7hzE/Y?=
 =?us-ascii?Q?g5Xo7IjScUhF6/BIsE/HT4E7avEpYh2dc1fWQsPhM5/txora1gApjgjgtGjM?=
 =?us-ascii?Q?/IA+w0UVWQLufxdPtt9BFEg3vOdlbMzZrs02M4uu08vWJ6UbJjvYgv4XC8W6?=
 =?us-ascii?Q?I5P2XTUl1+QhojOkUA4tdDxF3Q4wVQ6fOtR5Wd9ALUZVDsAMeOuS3YhLl/0L?=
 =?us-ascii?Q?RB5zBkfPvnxA4O6zOM9xNng6VvS+d4vEq2OVknSG2PFuF6rG52Ki3WtHyPyD?=
 =?us-ascii?Q?YQMblAwzJahuy6xHJvXIqny7RMQNygw7bwHyojbUJ1/cc7I5WGqP8PSAdHLm?=
 =?us-ascii?Q?M+gm1r/GzoJIkszNELeTb7j9h3Bi6i/b6zPYwISpWpk1SgHqqsDAfgXxxxXQ?=
 =?us-ascii?Q?dylVGayVH+mXdX/M+0DlPtn5sm8eSfEf69Zj4Yhws3e4UPrd5VZy7TlAeKMs?=
 =?us-ascii?Q?tt1O5SydRhlCXbU1vCBgr+LcpRhROmjxyrvba0bpvxxU197O8zUA7DB+Uja7?=
 =?us-ascii?Q?72dPqwTcnmGh4OInbZQ1SCarMGBahgjOpeNAXDMEdHosgnbO5ruSFwB2NQbo?=
 =?us-ascii?Q?cxXRfVghWZ4TWi8CUNsFYOoGIqQVuxtnH1epzYzwJmPiypPQxGIOjiLn0IFx?=
 =?us-ascii?Q?ARzilZhm7cwEjyiFBDiIo89NKnRgC6QKNWC2MJroQTZO3j6qBmKK4IcuDLs/?=
 =?us-ascii?Q?nAsn4RQgRlv73H6NVzJ1t6M4WDA3NNbxJTx3JaCJDfCWKwFQUf6p84nlKzc7?=
 =?us-ascii?Q?wuYW9edTUIX9msu0EZ9GVS+j8HHJ9gVK2YQwNXqug26oeOhhMSCSmMqh8OdW?=
 =?us-ascii?Q?iLpvn8KEx9gpSzs1TPr8GMjyjiMUWC1FRUYEf1ym4MaZoCOZmsrez4DZUVEP?=
 =?us-ascii?Q?CpqfbKRxCYfWtEeKBEVtdaMwkj6XKfDOhZbP5Vj6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50730702-d566-4050-c90e-08dc59de68d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 04:18:15.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oZi8gvOrfw4k5WTcMv/inCX//Nh1Z/CqIP+OV/kCwrNHC4XwxtMpnQ1olb3WSP/Lx6iluxnv1/ATmblp8Wg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2048

> Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: remove useless return
> values from dbg prints
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Remove printing ret value on success as it was always 0.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>

