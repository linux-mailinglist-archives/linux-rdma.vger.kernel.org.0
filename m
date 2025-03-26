Return-Path: <linux-rdma+bounces-8976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6CA71963
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346FB1897140
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DFA1F3BAC;
	Wed, 26 Mar 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kW1KVBOD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7E1D95B4;
	Wed, 26 Mar 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000343; cv=fail; b=UeNg/BTT1XtmDehSxjvWj0xcaJWru5NP5YwN40NFd1Fw1Yl49/h6ihHVgg1bq+lnvo46ETlvpvpEqgWXRbfBYTRyG6c3UD5Cka3G2YfoLmOHFnCocJvRsOkAYd6sg7Gsc4uzrCT0KPdprIQN7WOeBC1OkIdHYxTlTD9z4MDQAyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000343; c=relaxed/simple;
	bh=X58NOOsrV2wQEkH8JtCXE6hIK2Y/mQ4l7FHfixNuXtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sa+o9rtE9AUndM+tmHEYJ6QSdHoJFtfsthkTl+bazdrHc4RuDNpCqtKN+jf0s8cpKdv/zAOWzJF78K9B9l5x3hvJ/ikHyr7dAYpcvn8EB7YjPd0sNXZGKQnHg+Zu7UvXduz0cLI8hygAr9RCE3TAxO55C8uYxr6S7wI2uVlWTg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kW1KVBOD; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzimlUTbob/T+d6v56JDbdJ6nvQm/KSk0JH35PqbeOJyg2DxOLoFxIngfUyD7QqZFF0D/mdSFRBz7vL0lAj6R3oEWrboPXIyKVvU7xhdz3vp7OJemB3lm2qaruQkGeS9CrHP0JiS6Nldil5vUwWU3aKI4nXER0KkUYfeu3s7nhk4xHwbr1VshHPX/WCINrUPTVT6k+yLpvzR+u3PhgJUSJXEHm9hs4/CYquyVCUU/TMMU7ez/L5IWh9rOrarhgHZP4Hh5f2RVSU2+ffK+nBRokWY+zu1nugn+ylA2nLfiKTcIvV9IvBSlPhCq4cvwSA+yqOCEtWCswG3/v9tCOralQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4ZEPLT8lU7M9j6fbmzCNc5t4nz2zz0yFQl8+NGGgYE=;
 b=Cdibptqz2Xv4htbw15S5frBdXJDGq33FnBnuYKqfhVqLxOsAt2d4OmssQ9e+EElbji4upHHx2gstDe2Q3zptoVgPssUvWxYf4GLZQq9/R+H0bE/KLCLO7WPPqXktoSwboNtn3OrVMfGRAb3l0M6QN96n6fMCyfl2nYxFK7Ee/4rIO5ZV/2szQo6PcoiZ2BOYWxZCVdYHVtnKFljL8/kQo+hx3NtjA7ZQb+IcmLoN9oeqNvpTa2kqe+AYps6TywTo8kh+w2FwE3Lco35kwvJpR4rz6XnOTKgUVdTTiqhgVdqhDMblsvar59dWicPyTajWKIROtrwKWqe5SAmOYPWzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4ZEPLT8lU7M9j6fbmzCNc5t4nz2zz0yFQl8+NGGgYE=;
 b=kW1KVBODCniCUG3jZhNiL1Hm72w3R3pKFOsixOoDvx6nlUWpuMQ9MaVzzgaogC+FVCI5+uWqccU4C7RM8U+ufqeORKo2usnImcpdLuOZFVc33T8uRPRzUlANLe3hhZAupUQGiFdIH9jV4rpOxeAtkx6a8uyB5QQ5dvYe9AAPg615gJM9+c1ZMP1KC9Dqb5A4PZdIECGK7Hnmc9svc/pEfFvXT+LoTslcGySOjpQpi7xh1ZRadzPOfuxEemn0wQJfuzR1/BQ1XyZGTiq3H+OUTbpa/2XiNGY5yyv1tecy8PLG5M96m2vZ6wgWBEP2QDzRGA2h+1zCLPEef1ervVGr7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 14:45:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 14:45:37 +0000
Date: Wed, 26 Mar 2025 11:45:35 -0300
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
Message-ID: <Z+QTD7ihtQSYI0bl@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0843.namprd03.prod.outlook.com
 (2603:10b6:408:13d::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cacf9a-ba73-4dc5-1a8b-08dd6c74df36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qubxsUzns3MilOCFTMlElLUg5JG7XeUf2YQNLVV9YyovwYglQ3T0ZhBTsgOI?=
 =?us-ascii?Q?AmqCwgDJNmHD189KYy38L+3g/KlkY+uSq1t8UITISyvWrmRcvfc6HhvhD8ka?=
 =?us-ascii?Q?y5GWV3ULM0LoMc73yY7Yua1egzEGHeDngzzBHk11VrPl8c/WLGB+APAPNuC5?=
 =?us-ascii?Q?LFmVTcJAZ+fSD62KAICUKSpckv6QXdvdF+52D8kfCLgme5UTAJwFl2u8BScQ?=
 =?us-ascii?Q?BHI1FBKEE+tpcIe9mEMLfVPDABmD1qWW9TJpoHX9BXgO8un5ZaJrFwY3VBP0?=
 =?us-ascii?Q?6IYvYe1b7SH0r47APs1SohLwWIPReaWE7jFdGGwG8sfk5+9NPt4C+6AJTp/n?=
 =?us-ascii?Q?sWEG2B0YQXnRSs1eZ32DtbLJQn8oXL6HIXKpm85K9v7KNR4zeWUGpFKPaFYs?=
 =?us-ascii?Q?7MvxDbEiOj82q0Emi7GuEJxwL616BUZ8xB1ddLeudD4YtgVVmy0e09WCpVVU?=
 =?us-ascii?Q?g3DO4FYtzJGSMK1OJn1ggWA86kOZhmLMTWKj8DtO55a/SeqREBrzHh01FX9d?=
 =?us-ascii?Q?H5bQoG/2pIWe/K59TBKastGjlsnegKDc7MSCC26Y6+qvuL71tixU6vs51nJI?=
 =?us-ascii?Q?ijfhHJp7QIWsr1tB+1TObtEoZ7qJSQirXeGiGms2K9UY7uQR9YypAWh6bn4E?=
 =?us-ascii?Q?ZydLS7GsIkXoixu4zSL4pgd+RxqLU/q6Zw4tA1vMfvp+lwh0v5rhdkuvA78b?=
 =?us-ascii?Q?MUjTUsnxvNm0ThMsnEfMGlcK3Kz4ssTbMtxPeOIhHJJ1Kk2+sLb4j5/jH0Zr?=
 =?us-ascii?Q?W8d/WRuehyyqsnkckCbfDFSianZuj+HZijhklfrG/FxhI5qajDiEqC7D7QB6?=
 =?us-ascii?Q?1lMDqL8JoTZzyCrfXNisXvSGIJe5htK8Q4fgzD2lm/INMAaquHmOTvsS1brg?=
 =?us-ascii?Q?ljBTmDp+j+6duFOWK4C7ythCAknpqd5VESzyhKnuWcjuzFIJgDo5j65kjTK4?=
 =?us-ascii?Q?J4P/1aGkqXTxa+U6aTzYaC4hYTNpKbkTE6mTfrGHudevc0YQN5i2YT1L+S7T?=
 =?us-ascii?Q?H54tD93pbhZ7cwMFCDVAhdrhr0ZKTmoQtiVB42MchiS5hDf5JGizDbMqefFy?=
 =?us-ascii?Q?yoAOuZ1cg7o2WaqtjtYHAISBEvAEwQtQXBKlYjOX8tAVVGSBPGT+8j6QFvNR?=
 =?us-ascii?Q?17D9mzLKbpshx9tS4qBcJjlWGEjgVLa+mBMaPY7mVHmt0z/eP09+dm7HIHyM?=
 =?us-ascii?Q?Kxpj5/xkn1fUzMfXKR0ZyyyZro2FU6lrTWSQHFWpVwZ1Gq+QnZhtMVmIzl+j?=
 =?us-ascii?Q?TvKtdRfCJ/GXji0RPJFzEureuschV9Ir4+ZejynegZw1up1nUL1ji2j/3f/a?=
 =?us-ascii?Q?pvmPVsF+tGG9UUHNMiKVrHAeEyI+5gWQ0xiFJLQnGsSTLwHFTisBTiknhnRp?=
 =?us-ascii?Q?tQBZPNf8YED1X5R5Ug/0eUPBR091?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKdSkdmZAtheqT94raZbFfob649CzNDess0C3oyeS1o14QuFwOcGyGWP6f/I?=
 =?us-ascii?Q?nQZJbRwC19kqXqd7IVfI4FEsUCNi5nd2wRfM8v3rJWVse/hvB66A+CY1c/Rj?=
 =?us-ascii?Q?BYLVj3s+8aTUcAWb7k0+34ISXIIeZkgDB5sc+aAcuR85Mf4rcvuSFMwyUbbt?=
 =?us-ascii?Q?uSvpGTMPwI0vzQmsuWnL2xUSTcUrf9yMoUWnWJW+Im0MiU2ZAPbQd7mSUiZp?=
 =?us-ascii?Q?kVyZAPPubivY+gClqsNe03yWk/a5Tidz0oeEfAvPWJswRhhR01qK2pqTgiG5?=
 =?us-ascii?Q?2hs/mT5mKEaFWoe4Os61y6TurEXWb069Tg4c6rI2I8MEUlIK8UqAjfxCiPTe?=
 =?us-ascii?Q?US6jilHuXXnjGqqq4goONlhEN4HQ0eBgA9kMvDHAdpVXcVovP37B73x3lyKV?=
 =?us-ascii?Q?LIDN4R3LI2Bideqf5Z/c8ulrfe843jgmLvah2+fEmrTseXjAAKCFkk5FFjou?=
 =?us-ascii?Q?56dChEmcOlkdMMi5VbpCuHLVfTrRCNUyC1SYJobxWcONkogyFtqKU8MXNIuL?=
 =?us-ascii?Q?e9IOX0iiq0MQhMecgAPPMt7X/0FHc0s4P9mzttcmX3zcxYfvDJfFE4Cc+i0t?=
 =?us-ascii?Q?Q/FUTZBFROrBdd+IAY/EnDzgNzl7BYQDDkMNJUMMoTPukLcBA472yEcPHjIs?=
 =?us-ascii?Q?i74oOFWOIgJn8j9d+quB3jkELOmB9rgdBkt3uzvz3kCa7AruQFPxa3YLQN60?=
 =?us-ascii?Q?jZUF6R1WS1RR3KSQpAgHCIKRp+anppIgHl+UYmoIlNJNuzVsdKlK4my2lVcn?=
 =?us-ascii?Q?+f9BMOWtbyMkw3b4XuRjhDkbXKAEFkU7UdV9wPdsbk2gtA5+Ek/e9DGfXjDC?=
 =?us-ascii?Q?h/9xQEHGGkKRmIZgHPeLr8daUC0GKanw/ERfeoQBdHgVa8es657Vzd3FJGJH?=
 =?us-ascii?Q?nD+geSw6pHzg3fnlOwGrxg5b0Z4NQE7TExnqXPFQwSoFJ1XeFuH96u0dTlfi?=
 =?us-ascii?Q?t+5PxKV6PcVOmSC5mjrxCACu4MD0jcqu6YrIExAj+3fzIJsoEbai8MVb/8yd?=
 =?us-ascii?Q?aXo0IlEK+UGAgyVtJqIJxTceFd3PJs6z6GJUF8T3gQCvkrfsdo4x54hMaj6t?=
 =?us-ascii?Q?adQam60+XEhKIXjZ9r76NbrwfMA/OsgJMAUiDcA1y9kumS0yby3QY1Pz8QaW?=
 =?us-ascii?Q?l0WdBv5Lm90b+9tGqlu1Plqc/Tug91XnhFW0nFCFSBdcyO5/080vgdHra+Sv?=
 =?us-ascii?Q?JL0b6sGIcVWDMooTTtIe+BzgCxQMuOsftZLj2FnpohnEwd6pAzoJUvAShHy3?=
 =?us-ascii?Q?xM0BtpST3a+4nHLCX6eBYgUffaVz+4U3xCClmja5PRIWDGpjD6fOxiQApDQP?=
 =?us-ascii?Q?xy1MaM+L8lwfYPes+ysYuqoOBie80Qoc3O0XOO4FCyzhGRVfUIwzrPqG6K70?=
 =?us-ascii?Q?MmlqFaXLMThgwpSuGAOKHFjXHgEzLKbxbmdjU8xIbjJZQ3MVgmfSKv+9t1Fc?=
 =?us-ascii?Q?xxTnL7nePSHZYgwLc5oDlrCXwAt9npmQVx5q8D4+V/u1CXsMMw5YUqQ9wD0H?=
 =?us-ascii?Q?V1TH4lAFZKyDL6WMnqHsr40dMmEGHVFL44sTbBvuKRBlQ4ONdB4JZbMqCwu4?=
 =?us-ascii?Q?dTcx6qK2NytBemJwIko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cacf9a-ba73-4dc5-1a8b-08dd6c74df36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:45:37.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xi+kDeStcKbxFo3EouwdNaoG7FRq+99hLJgRut2fwe40A94aakerP7qZvWeX3tu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

On Tue, Mar 25, 2025 at 05:02:37PM +0000, Sean Hefty wrote:
> > > I view a job as scoped by a network address, versus a system global object.
> > > So, I was looking at a per device scope, though I guess a per port
> > > (similar to a pkey) is also possible.  My reasoning was that a device
> > > _may_ need to allocate some per job resource.  Per device job objects
> > > could be configured to have the same 'job address', for an indirect association.
> > >
> > 
> > If I understand UEC's job semantics correctly, then the local scope of a job may
> > span multiple local ports from multiple local devices.
> > It would of course translate into device specific reservations.
> 
> Agreed.  I should have said job id/address has a network address
> scope.  For example, job 3 at 10.0.0.1 _may_ be a different logical
> job than job 3 at 10.0.0.2.  Or they could also belong to the same
> logical job.  Or the same logical job may use different job id
> values for different network addresses.
> 
> A device-centric model is more aligned with the RDMA stack.  IMO,
> higher-level SW would then be responsible for configuring and
> managing the logical job.  For example, maybe it needs to assign and
> configure non-RDMA resources as well.  For that reason, I would push
> the logical job management outside the kernel subsystem.

Like I said already, I think Job needs to be a first class RDMA object
that is used by all transports that have job semantics.

I expect variation here, UEC made it's choices for how the job headers
are stacked on the wire and I forsee that other protocols will make
different choices.

Jobs may have other data like addresses and encryption keys to define
what packets are part of the job on the network.

So the specific scope of the job may change based on the protocol.

The act of creating a job is really creating a global security object
with some protocol specific properties and must come with a sane
security model to both restrict creation and restrict consuming the
job security object. I favour FD passing for the latter and file
system ACLs for the former.

Jason

