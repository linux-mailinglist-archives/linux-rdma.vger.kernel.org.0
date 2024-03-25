Return-Path: <linux-rdma+bounces-1549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5888B044
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C8E1C28AC5
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3444C86;
	Mon, 25 Mar 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IG14MS+U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759741C79;
	Mon, 25 Mar 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395664; cv=fail; b=OZYcdM8UPsa0XxkOpEW7pMZLze9dWWYzX8ZnKHAAEQWM1AQ4zzUzq1vU0BgtTd81MXq2pAzf+T9n3Swm+wzTMf2UUyakylZiIs5twkNLrRSbNl8uEROujRLvxnqtCsTwJ5GyX9MK8HRZNz5Es9m/knY/TwnQtrfKE7oz69akwBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395664; c=relaxed/simple;
	bh=SEgSyGXIB0M4kJpTzut8i5LwrzwrhfZOq/1f0xewScw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlpPU3MLr2hND4/fSqESPkERW+TTyO14gBHMHw4j3amBtQaKvwJhpkVpkQjLynvmtlp208gqG7p2ZsaMhYJh8UX61Ev2j11MbopxJp8+v++ZJ1qM/krLxnlfl1qTf6mc6AwyfeokJFwZjV+mJcHLfTgyB0Y91UAvaBrc9tDOi84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=IG14MS+U; arc=fail smtp.client-ip=40.93.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnL+23u3f7mRHv8tMkk4U29on4FfWsto/Jrz3STheP7W3aPpM/zszmQMVX4Su0oRpT55plL2DqoL6mzaRMiceITV1VDFhUavrNdiVWkKTNOhfaNofHqZIMNYeKIqzDAdu0Z31Q+Vb67npksrzO5bG8cUHk86vveCYkpJUzdeB0O9K7lk8VX/8bYOsQJyeQ2Lioleacfh0qSGV/ALGGveYtlw9PT58vBvrRKFHT5Bi1OeNI4OM97MTm3l9e+36oxllAFYJ3vR3CcKmInoFbN4Ip+FhQ2oYOSEn11RmBF2piFGNSm4plBaSS0WmUlWRf80zEBW7cnSumHEcNZC5DJfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up2MCnchd2ivJNkwnfytVIR1+3ns20QZQNSRjSMNg/M=;
 b=YUJszhxDYIFc99b0c7lWVCAB0nYS5fq72nu5gL1TPkapkZUfMsJ+cbef8DrJBpIkky4gT6vcv0QHFKf16FlgOycyXg6wuZRXd+IT8I8eMvaE0gtoPXlC/ukKX9dI61gtsgYrwe97L3SbfarQVVldAOPqrhHmxor4DT02fFtrWuJH+pdq2NHMAiHLTa6jwDqtzgjnr99GdyziRKwrqmxY1THtCFlSZiu7FzpJRn0lhSXh4Lvua6hMc5RBaoUMugz6dMto+o7aUSqAelAmRYqtQd3NEub9wJ57eTd3ro3fG9DpMZHjpWbGC0ahNvhMduy0Vfqd4hjXJeTJlHEMNE51yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up2MCnchd2ivJNkwnfytVIR1+3ns20QZQNSRjSMNg/M=;
 b=IG14MS+UuhG/KBt9anLLKfdo47M/nO92Nn4tBYCfYqJvnl++i8Cnpt0038zL7ANDvgDm/a+rXBmBM2qTzPQsXN4pnFl5nZ29bC0dx3ZDEFZXI4AaX9M5afSOjcHSEa6CQgu7Z6JFbuIc+2j2FnzWx2e3OqGXBn/OLAreJlCbf6A=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BYAPR21MB1319.namprd21.prod.outlook.com (2603:10b6:a03:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.20; Mon, 25 Mar
 2024 19:40:58 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 19:40:58 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Topic: [PATCH rdma-next v2 4/4] RDMA/mana_ib: Use struct mana_ib_queue
 for RAW QPs
Thread-Index: AQHaeh7xOJCPEnE8T0i7r4Bx7u7kA7FI47Rg
Date: Mon, 25 Mar 2024 19:40:58 +0000
Message-ID:
 <SJ1PR21MB345735033DFA7CFF14B7BBD5CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-5-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710867613-4798-5-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1de6e87c-a583-43bc-aa2c-c97facb0b9ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:38:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BYAPR21MB1319:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 17H6cSzNhT+qXwV7pkWpbAtukJVmKGf0u9Snz1CjmnRQw2996i9CsVFU6VQwquBHlb95zXWBSfl8+arZq3kIvDxvnPPqiyes8v2hJfaN+CwxtkF+bCuCZ38ZojwWPZnzxWTa3nkcfDYTTX2RNL+Ys51Miv8ye4vwKsEiINLMLyCD9u3rCp5L+8behipnTz+t26vwTbR8vSOk4JMOGDDYq/YEsOT4RyYO1NpTW/aPDx9QsIGr6S8hHzKZEPlQLIOGsThu/Heyk/w1GFKArsSH96FuTzeO10Do44QoLs7mhhCke7ngQgPupHSexCZ9f7I7v8JlvxLM7FVTr59iHBySw9Qj2/L6x5LwQDwTMa8BLozp/J0efDks1G4wZc6GT+uRRCvmaoIumid+7zRxLubydr894b8+FPoAkW6z7ZIGRnUM8lUBvZiAxpZAyKsSOq1IzHC94Xy8fBH2OmZK9ueB30llPk6/jaEq1uj4XalZ4fx4Xs5aK3C02+NopbvjM0Rhor0EEEjOqrA05efLuvW3DscaptjTXTRpHFSx2nN09vLLQ5URxnS1ND4LwbrtBPqOZslWrmQ6gVjr6xZL2tHU0JybmKIUj5W+IB8VE4NUde+J/SJ3kR9cquLNnbnvZrAkDZgJAvEkEt2310JAWM/hHyBv4dHtqxNM8wAJOX0+OnA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HLF9W0uA0CLMpOa6Ep3dBHf3GyweBxv8cPCoAsKcwg0/aTYpixLuzV/W0FoH?=
 =?us-ascii?Q?TugpCkeNvXrikB0VC3Td2NrVzl5l+EtsuRDrJn1p6bby7DIjpUySxIrPrQr2?=
 =?us-ascii?Q?+Cm4VcOzS6YXYvy0uO+dkRRjs6b96atHw2iN/0gEenvP9IkzMLV39ig6uSGe?=
 =?us-ascii?Q?wN57layC9mMgQWLfmAC6EYf0VS0fbyMi7BvFEJyAq6K0CyowgRB9KBJ5is7U?=
 =?us-ascii?Q?CURKsSRJiNH9Zt43V2knCUu7da91MbXBY56mUWMsCQ5Z45ydvlfy++GpBgZ+?=
 =?us-ascii?Q?XpVYJfGn5Ox3MgxO1za9DB3UoV640/uS2RnknoErE7kR0FoL32nJjG/BLicv?=
 =?us-ascii?Q?RT6p6FXxh93m7aLp5st5xtV7+5HwkvYDNPj6len29dvoG/OmFSRZ/+R7pysY?=
 =?us-ascii?Q?DasIK3MtFdb8xvQ+fSj/1Vt4YRR6FUYACVms85vohOgIBkfDTJUnv7UizURb?=
 =?us-ascii?Q?FbyDDKPBOttuCHPpt9hf65lfyMW7nWCPE2AqfE4vFeXJmtk5Gq12aArH9JVV?=
 =?us-ascii?Q?f6HQ8ZLCSV79YV+P7fc6OiDsZRzVAERLuKBehJaCYlxK0UGsjF2reJN4nqSi?=
 =?us-ascii?Q?MXpZnU/RNsJG7TLcKWtc/tjVisKsDBR9BdM5tU7J0W8YnANhQnNdJ8AV1OQp?=
 =?us-ascii?Q?8/HBPJKzlKytE0aTETzxORfYxuQ1S05kMh628+nGy7gWbPrHQRSsCpxEv+bs?=
 =?us-ascii?Q?o7zFBm8GOCMWobifDDP4DdJpe8afiQOLIBYWkhOy2ExNlisFNZ5Sda5/I8Sb?=
 =?us-ascii?Q?jxrTYqe5PFuiPv90jT6Il9vlIX5y4BDR8Ds1DlyEJOGvZ652tlCC5XHWjEio?=
 =?us-ascii?Q?E1yIHDZ+LcnzdoogNMWLJG7SgpysNXnYKrOyFKp1+vMgp1MAx3w2AWwU1Kz0?=
 =?us-ascii?Q?M8/m+hmv42yc20fT87SpKgAhHWWcOfEIWTtNO2EW7uA9j6pJHDa3tkKjW+fd?=
 =?us-ascii?Q?01ZnCAE70GABnw9QUuPJ1fawBJljosR0zI2Xg+MRw3c6mzjUbi+gdEUK+HVh?=
 =?us-ascii?Q?kRWix6Oqnt6/r9CMxvfObj9TcmS1S4JN+X3shkEFquyrcsu/HKApv8ODnNSI?=
 =?us-ascii?Q?P62kL0s7B38cDUD+nEVHG/Xu+tTT9bdq9/ai4+aZ91dGXfTz7v2B3zMVq4v+?=
 =?us-ascii?Q?f8C+ICnUjACbMhcOc0dMxtdF8xjBCDJ5Ai/sNMdIhXjebmMkjSuO4WC5ItwD?=
 =?us-ascii?Q?Al+EqI3nU+Lm7rX6/Jd0PQimrRKIGBtKqL4YtQeH1w25SjMR1mXukPZjb13j?=
 =?us-ascii?Q?05D6Zi393jKYUmmyn7EGM02dLiadXB8atCUdZPdxRS7qugLmkXsngX2sPMTF?=
 =?us-ascii?Q?w3YVPVZtHsiIH79aKkamBkvjYfl3h9fLAnhBE47fXH9tyBQnTwj4Lm9DJP0O?=
 =?us-ascii?Q?7vhpxHfmAqRsRgo9ZJxSdcGnxN0n1UAs++RwF1oiKMFIyAVIzaC87RCs52rG?=
 =?us-ascii?Q?UdWHTZtd915Ol69NdjL6sHUeO9wOXQMFR+OsmxjOKhlT5oCCR0LbYzABnaYH?=
 =?us-ascii?Q?ZE+icPt0+doVBggdesrUDtb3Mq587fzGd9ef0ald8VqyQbyPM4D5i93Hb+30?=
 =?us-ascii?Q?X5B8E7y0OG1sSu3w/K4mnPySac+XvrGA1AlfWtkC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44edc098-8fc8-4738-1921-08dc4d037ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 19:40:58.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3q3kC2/N13Fp9ANUaDhbTAhr/50o4Umiu9ta+CQIIuAqsk5LcBMQe5Lo+SMMyhk0P2fLorGbOTN+otYtoGWXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1319

>  struct mana_ib_qp {
>  	struct ib_qp ibqp;
>=20
> -	/* Work queue info */
> -	struct ib_umem *sq_umem;
> -	int sqe;
> -	u64 sq_gdma_region;
> -	u64 sq_id;
> -	mana_handle_t tx_object;
> +	struct mana_ib_raw_sq sq;

Are you planning to add another type of sq for RC here?

If yes, use raw_sq and rc_sq in struct fields.

Long

