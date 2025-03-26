Return-Path: <linux-rdma+bounces-8982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8AA71B30
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 16:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A547A6AB8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F91F4E56;
	Wed, 26 Mar 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7N4MdSg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DD1E1E18;
	Wed, 26 Mar 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004416; cv=fail; b=t850t9T9C0EqcnEY1jkZcSMth0eaTbUa9IgKzRn3djfnYLt8nn4zKB61oI32rl/279NPu2xPACvjynVEhX84nZwFNqMI2kQWIxQIOIJq/tLOXTFlfWF/nunELKBOFiy4OjWBmbWiESdxMTzVVsyGk3dgYbgVuoLaUSfnoMx3vWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004416; c=relaxed/simple;
	bh=h11GbeAiL9+AfgMrli3KJuRzliUY7T/q8dkkMq2TyoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aHWTKfGVAJtaMy0cySkfUXXNBqVQnRj4WSj4ssQDnjBf+fnRmUCu7lksPbtwYemP1/vSksSCygfvhW9L7Bc6WsomU/ErfVOQxHcUtv2GcvvlP7WuKj441lA1wdmnykAGFaT99RwYrfqfzw1c9it4cS98+LmlQTtHW/KPbpKaqg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7N4MdSg; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORc+TW+BSM/oyvMrf/ya5JmkCJ+Qq4CCGv2gLzzUfIF95dvvxg0YA8IzXNGK3r2fXqGtqfrOj1wjT6JgnvT34BhJjNwQqF11rIm0WIfXY57jvwME7jBGuW7yhRND0E1a6jOxVbjd/myeZIcsm94eHwJlzQvF6yxcoj1bZdQm2zFqs159CgXaY0annPmyp9Zp0lUrXTgxE8DhvDIQHYNjeWdT6BkX0t/ynofFmTmRiP6Vs88ZhzkXkBTkJjMj2zZ5AdpF8Yi1aZGCW8bdMU9AoouHFczAl3KHWsds017cwEAz9dgX6o3Xy4ZbDuQJHk4M/TiIwqHx7os05ulmBe+nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeOEWytFrtVEeHgCTFhP+WICI+Guj6aaaucVrhNaTBI=;
 b=NNHkQkkOkCyCNBM99+LnnK9n3DonAeEMCyD5jJ/HcSTas0JP+0p0R2XSSeslyi3B4RCj6QkalbsFDtIkntc3y/N8KE2NC6PwDdAMFOYAgWhays7P7PC3sOIP4mIbVdPLydzc24UpFw1IjXccwExm5jRUyO48fzlNlMhXZmj3J/ETtJPje0ZZDxgemLfMMzgiEhbur31svL+0CwZ9vFSmL1mHp2jPXVeCETqZtFhtLTbTEDVZeg7wEfW43ijeaqJSvW17bNRW03I1Ct1O2WRtDHH9kodwflKetNKD73raVATU2Ka0ldAngjerpIbryr/rF/rPoFrPcRMtSU4LDfZnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeOEWytFrtVEeHgCTFhP+WICI+Guj6aaaucVrhNaTBI=;
 b=D7N4MdSgahWeP5+IW/hhoOXSqaDCkYAwrZPgrmcvGwXrVNOzYW/576ny1yTCSufaxSQx89Q+nqEYjvusxIBmgKq5Pd6UAthpfftv58HM7WXowJvAQL1NdCWls4wePi6FiyMUiM8lBRA5ri6u48lXWwefWBxTswn9SPxZS7Wg9mViMG7FTithHS2ytTsYnN3l5mAaTThC54/HsdA5negEiljqkpyboHnJqXxD66O79y6MpyA0Blaff8SSf6/vulsndIzrn5SwNgmp2KicTzPLbhCJgbJv7FXljGaBqVz9niBQ3DtLVfx6H7gmxhtAjy0SAcc5PPHNE/e1aKvWnYxp4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:53:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 15:53:31 +0000
Date: Wed, 26 Mar 2025 12:53:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <Z+Qi+XxYizfhr06P@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad8534f-71da-40f8-47e7-08dd6c7e5b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eJO+hby+0T8SLFh2W5ZT7YaCZvaEysQ8c7KQEllqqAC7QUUVcPY5bGOPMEf?=
 =?us-ascii?Q?g0v719ogshW7MviS//CZCAAiM1mB7tWYuobaGlUH7woUbEBS2bl6OnUJAKYk?=
 =?us-ascii?Q?PQcPuyqjoqDRs7K0dZMfE9GeCWUpdkcA3UCpBPnaDo1pcyVc7TGjft2Qd7dE?=
 =?us-ascii?Q?0mrUkniYe/YwLPqaOyyHPte/mkwjNxpULX2Vgfhu+1E8+lZYtGaajQlfTs+X?=
 =?us-ascii?Q?taoRbEHJEGMDdx+McobJXexM7HC6VwGrNmLNVLAvgA0SBO8acVjxMZQC5suY?=
 =?us-ascii?Q?lMPuOOQSRz94xjl8kifitdZX8NhaitJSnbR0h/32KznSgR6kaHLTFGLoF+XP?=
 =?us-ascii?Q?Szrck9sjZbM+Mb2m2FNR84Yrg1FmKewI/hYHhEqRiVP9nP0tBgGKuSCD8lCN?=
 =?us-ascii?Q?GzQ9ABB+Oo82g8RmsknSjnNY0075H3jsPRLpnwyMSmF290CnXcY+scVF01Tn?=
 =?us-ascii?Q?W96WG9/4ArN+5KFOxRjhKWCOYD8OKYS2UQfP0GWEiZTaPwK3sbycU/wwD44b?=
 =?us-ascii?Q?70iF0zOnG3JisWwKL/oGdIrV/ZvhXLNRW/aCC6GlWv99vkD6jKN8HuJeW2pY?=
 =?us-ascii?Q?MDUE6ZHq+NurnQay534xuHmoQf7MmD6BOsolbkPBg/11XXF0+2WW90aRAQcn?=
 =?us-ascii?Q?wjjW1QTsP8UqaIlLwoKHl/ro4aBrLn/VwVg5cJGvHTg3GgAjnvSnPI/wg3qI?=
 =?us-ascii?Q?r5OXRDYmj/4Rlzs0IwW7rr2WDQcGSUBohkP4It1duZcT7K2jQjaX4WcxllJD?=
 =?us-ascii?Q?h1vHemdC5nHxKLGa9T68wFhHw/qiTz1aprywgGJVqLk0nREFUv6vSkTixF1M?=
 =?us-ascii?Q?uG6D351wwxXEyCa7zKeR1U5dV+0UKQrHTZ4SQlZq1m1R65ltxOmu+OcCrAnH?=
 =?us-ascii?Q?/Y/YOrNXipmatJJ4RIyW/Wiza9zdTy2WhPNdxBgQweSENIHZbDcgtnoibuke?=
 =?us-ascii?Q?rmR3eUoxQksHFCOf/QoxBKq0A4+DFwPk/mY6U4C6Ty0PPg3BS000PmjiBCas?=
 =?us-ascii?Q?bwEKrP6IJYuFt5Svv/LmbI6xH2R/ECMTnu43cpBIu/9daHRPQEfdv92SmGbV?=
 =?us-ascii?Q?890If7rzTSGrADvt+Jt8PZqHahJwV1lfLV1gougrNl04TALwsWiCK4ZTKw1P?=
 =?us-ascii?Q?JgBtU0w44xTWQ6CpdK1OaVDU0n1GYYGxg9L9JdSn6YUOJ7QQ5XpZ4Oj6CbHe?=
 =?us-ascii?Q?6GDnaVZKzuTtNbR/phuRPe3Otkt2qgIvCkEv69mxKXICND0+H0W2C8OUyLc9?=
 =?us-ascii?Q?UhBZZrfvGdq+0yJNIYdfoi38/hDUbNsB95Xf5px1pMT1289S1czqDoAP1eoR?=
 =?us-ascii?Q?u3wDFF7RtdgzRYniKF+seO5sG0z8CaszJjSTkBpvs2fD2gpqSAeaL+/sOq0b?=
 =?us-ascii?Q?XjubtUZf2H2hA20qYuJzO8dNiXIv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RHFJ+XCkdTuGL6aLRS1jyoO58QB8oh2U9RlrNKIipkLntCWcc9+3lhB2pK+?=
 =?us-ascii?Q?XHt7DN9ELmvKCtNfUVb0xK5btLSqjtpod7t+NdBexH/T9s185Uk1XTifi+jg?=
 =?us-ascii?Q?47TlGuZSsTpu7U1mKbdGsJNk4l/uvttDCYjwLjLs9A73g10uuGUnRb9v4ax3?=
 =?us-ascii?Q?vanZxgPPshxT8oXtagnUYDt0veXI6BLV6xzBoRcFiZnfDxtL+3t9Ff6drpXk?=
 =?us-ascii?Q?tZ3R2raW6Rp0vMSqypS+NMCAjjpMtIwlJup9thrt/TVj8CEsEYrMzPxFyIEc?=
 =?us-ascii?Q?yVFLVRFf0VkYgxLRv09LKsa0Mc2JejTXwiVL5Ip0XADwJSz/siaP0r6vC2mL?=
 =?us-ascii?Q?V8IjdvqfSPynjkoyj9IjW6q0Pn+T1Vh+u5gejwgqHEhSvLhbS5oL2S7y09uS?=
 =?us-ascii?Q?Cp1vZtp5beSs6GoHP5NvBvDxY7rf8RirpJKoWLuChEdagPgZkMKyCMQotOXz?=
 =?us-ascii?Q?VbUgRuULAIr9tboQKWQc6i0vI/pAMZDz19JlSljimlkixPtPHrxeUv0l7HhE?=
 =?us-ascii?Q?dJRvsvX1/Qggp+AJdLLLNp96j0SH+Jp3LkbADZZQiZDjD9uuF/LC61XuDe7F?=
 =?us-ascii?Q?Mn4AvM/v/O207tGiU6Gjsb6HxYoc5P/RuVzdLcCU0RseFSdhr0N7JpgJVhwC?=
 =?us-ascii?Q?xXNW+UYbshjoU77UlZfyj8Qrl0f8jr8UoLeNQMmLV3+25f6f04oSala7AD5D?=
 =?us-ascii?Q?WMLbbnlOfOcz7qsNDrbAR8Y81FmmrdWOvbpPgtB3/YIjelgFrb0QnnD/hwA/?=
 =?us-ascii?Q?YUmb/YghBJBGiP8ZRJ5nc9NWxDzW88lxXsZTtkPOq8cj3UajrW/S8SXW4Dbh?=
 =?us-ascii?Q?BzavA7jC4RKTANpg71eImw/OHIHNHkTZ7swBO97U2Wn1DWhcWxTXf0HCRsgQ?=
 =?us-ascii?Q?yvirHCgiXPE2ijG4LxFFkVhJ9rO9JfVL38dsv5VejxBpxOldNgFaORmrYVZJ?=
 =?us-ascii?Q?5MusKTbXXpSLDNo5lJpNbbon9nMmd50nzIWQ8Voc8lnX0O9dEr9UpT58qUgo?=
 =?us-ascii?Q?RnXPjqdsYEtRBVFPMxMGVf+esDMtXr0/3nPPcUUUjqk4wB9N67WRtt+DpRC5?=
 =?us-ascii?Q?ioWGJk9Z/DBOB31DyVIBnUJ+Cw5Pff9L9a6lcc0MX1T6qcX8LlcES/0QTZvp?=
 =?us-ascii?Q?07ZZg7RozX+CIPcG5dBLmmIHyP7mmmqHij2Tlq1MA5dSPgK6pszwINUmIDIl?=
 =?us-ascii?Q?8AgrR6TLVxN0w33eJS/nKRY4/8BovHfC+ci7R9tqM7i5NQCQ6XkR6IQKDTHy?=
 =?us-ascii?Q?8pkhWsA9vEEBnQthf4wasMKSy9vXnMYZFHATXS9ZL/UzEzG7gVFk2M5Z0bKk?=
 =?us-ascii?Q?oeenBZZaMbMmQrpbmvNGW9Z/c+LPZrobcJVZ5A6ZdRwi0bxpWYDxX1SX2s/T?=
 =?us-ascii?Q?5JSAxBmRZ0XyNrSSTxuARr5leGbSKhIJA/p6fl5pId+cXqteTN1QIUwaUKje?=
 =?us-ascii?Q?0PhNbLFjgnOcc1FMEq7uHY6qJEZoV4/sHzqIBQxlB9fayUsw7JjkcHx9iwen?=
 =?us-ascii?Q?LINsaqnwAr3cYi8Yh5FGcoi5iNxG/u+SCZAWVGP1JrBocqTCDwfz2f4zJ3v6?=
 =?us-ascii?Q?jgitmd6J8KCepGQWig8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad8534f-71da-40f8-47e7-08dd6c7e5b43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:53:31.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W08S2Sc7ZtbglHndi4CtJn2cXtgFUy0ipJs2T7h5A9yy4qDoNw1XJ4ZeP69xq9Se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314

On Wed, Mar 26, 2025 at 03:29:01PM +0000, Sean Hefty wrote:
> > > > If I understand UEC's job semantics correctly, then the local scope
> > > > of a job may span multiple local ports from multiple local devices.
> > > > It would of course translate into device specific reservations.
> > >
> > > Agreed.  I should have said job id/address has a network address
> > > scope.  For example, job 3 at 10.0.0.1 _may_ be a different logical
> > > job than job 3 at 10.0.0.2.  Or they could also belong to the same
> > > logical job.  Or the same logical job may use different job id values
> > > for different network addresses.
> > >
> > > A device-centric model is more aligned with the RDMA stack.  IMO,
> > > higher-level SW would then be responsible for configuring and managing
> > > the logical job.  For example, maybe it needs to assign and configure
> > > non-RDMA resources as well.  For that reason, I would push the logical
> > > job management outside the kernel subsystem.
> > 
> > Like I said already, I think Job needs to be a first class RDMA object that is used
> > by all transports that have job semantics.
> 
> How do you handle or expose device specific resource allocations or
> restrictions, which may be needed?  Should a kernel 'RDMA job
> manager' abstract device level resources?
> 
> Consider a situation where a MR or MW should only be accessible by a
> specific job.  When the MR is created, the device specific job
> resource may be needed.  Should drivers need to query the job
> manager to map some global object to a device specific resource?

I imagine for cases like that the job would be linked to the PD and
then MR -> PD -> Job.

The kernel side would create any HW object for the job when the PD is
created for a specific HW device.

The PD security semantic for the MR would be a little bit different in
that the PD is more like a shared PD.

Jason

