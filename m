Return-Path: <linux-rdma+bounces-3777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225792C456
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 22:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CAA1C22510
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 20:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B56185609;
	Tue,  9 Jul 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AytCqX1b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E617B02B;
	Tue,  9 Jul 2024 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555784; cv=fail; b=ERbIPmOMt+2KmFZ+lGNCQijExPNAYV2CAT5Aa8pnznHjwNhcu0kkn1I//RxjXmQ3Qk8m98JDcY0dEVgOQQE1viafA3E97KDrKQSxPw7OhtleKE3eglhVj2HlUhiWpImLx1pIs1KzgVdPNXqj9SVmgXMNdm2r9cEi89M1zgniY2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555784; c=relaxed/simple;
	bh=jM8EANTDZMvsqT7cwgIY8YdmbT5yUZmOb1tfKYqrufA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eDzGREuBUt0qt36JZ2cJOl30O/3TRwZ7Y/QPV6Q3RQIzyMKbwD/YLb2nBsWjvS+x/v5ZXG4Mtpl/+3uP0mW+Y81NJXC2WMlW2piqZSqYho1kSYs3xtLZhPV5ht1ve1JhzkPhozq6plLbmxWF6hRghYR1FFDDQyNBg/ZXzqmGO60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AytCqX1b; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720555783; x=1752091783;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jM8EANTDZMvsqT7cwgIY8YdmbT5yUZmOb1tfKYqrufA=;
  b=AytCqX1b1k0MZ7wj/Sm1yZZTk5KgLjhduxg84smeklp7J7xJOnFsPpvj
   oQBnNbx8N39ho4Ri5CvNFevNpjuUrY7RLAyNaJVYh7FqRFJRRiyO3rW/Z
   U0fyoMHHO3XzVHaOWA3zsJNyP8qw0TDN+i4gyUo93CNi8g23GwisePg/G
   0wUH0Siq4Y2W/gKWtXe4cgGuLj079pyICQybi6G62BImsY3/Us7JkfWxN
   O93pGbsBG55yN9Fpk83eqkow0Qh1mHk0auhJ9X3AvMCP4PJ577ykOH99o
   qjs6sC1hQDzky/LMBuYh2F6MxbyTD2l/HzMQ2Tpez51VKM9JWSwnWAFvz
   Q==;
X-CSE-ConnectionGUID: w5Lk3doyR5i4H95Dg4M0jA==
X-CSE-MsgGUID: FGLJN8OFTAy1MthCCtjCng==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17677876"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17677876"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 13:09:43 -0700
X-CSE-ConnectionGUID: IxHber+USCypsvvCVblk+A==
X-CSE-MsgGUID: +Z1yWY9XSKOXDvr0P5m5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="79122829"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 13:09:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 13:09:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 13:09:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 13:09:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqN45eIZFPjxY3ycK/PB0EIp7XgZCYc2SINngYBXTYXNw6+lgzCq96DwYVRn5OwAG/L5CtJWMiK4BYt5q7KH1WRzyoU6guIpbMcRKEyh6J49g6yFuCd06y9zKEoMhMdbiNpXE1UHgNktHL9zXrpwzSeY4UfDWumErNU3A8clZJvFtlxH6DeZsazHQ5KXPNq0IiwwI6kXcN6eoTs+bEaSxX8+3JDi6GxAq00SlD7H2F/aRgqg7Wq6LjiyEcBaSV+ePnlxPuWKEy4bOUWLxtwanDF5J2Gts9UadYO/8pEwUMJyNBKDpFmT1swhsaG373JgOsCCSmNHruxNTaSuNBaIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rhpcuOuCtAnY0hD2AlCZS/IrlWBDeyC4I7TRE0UByU=;
 b=NsPjM6qFx6gH6zUbE8IcFDtgdlCrVP48wiPmndQZEYf6N1wU1b+nLUFLKNwuIs4SwUwMnfB+aO1+8kpwdxDWCkZK/hlpQFrskqOri/3hNWn3DyKn6rWGO34HUtXTdn7DedzUPdjlQLFjoFmZMhIXrrqGi7Ulqr9Ig89YOAhorlLKom7kF1mQBeLKvcTSk1lpG9FCjk5QVhT0/RfP3KanVL7vnnG3JxU8cNa07tfX/NcetFcMlmb8eQ2SQW6WCMcI76ccrgCnpOwjeoPHOPzzUnohYFeT4ZzGwdWEti/1apAWKFC/XGJg38JxW+aRRkZVIPLjUO8twotqCiKosPNmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 20:09:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 20:09:39 +0000
Date: Tue, 9 Jul 2024 13:09:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <668d9900b3522_102cc29442@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <2024070910-rumbling-unrigged-97ba@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024070910-rumbling-unrigged-97ba@gregkh>
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d4fd75-caee-4cb2-f87c-08dca0531005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DxcXDuvE4b3Rr5qkSLE/q7LOr5Y6cQbdR8VNZsrs6898cqD67NsjMuogytuO?=
 =?us-ascii?Q?AeJS8o21WuQWro4awTWukHYX71Oc8xEbxNE+oJigPBf0/3L3H66YWRE3CIXP?=
 =?us-ascii?Q?Sxqjbo33r7RFVZwzHWKI6/EHa0xOVA62TXnlVMgDexOm7kwk+C+xpfKcyJK+?=
 =?us-ascii?Q?HyZ7q8JTdCW4tMeXwtM6kPnkD79YFO3mqPuxkcFMSfxOcvu69kRBMyFwqRBX?=
 =?us-ascii?Q?LKIvfUVQA5jlXCvtvMFZWpiz67pEKFd/olqZS7UGZlGGPmD2CpNLrYEFf54Y?=
 =?us-ascii?Q?/5t8IPKIsHxxUPPg6ut7wQouvweu4FCfO+I+tuAenjFf226Qq6sn+O5vOyTW?=
 =?us-ascii?Q?BtZLzTP8IHY7hZ+OWeVrc4sHLvB+OIzjjU1p/hpRBklNQGmwpKIJgZPCyXsp?=
 =?us-ascii?Q?rwQ6rD4yaT9phoKzRf/Wpda9hgldC5Q3hZ6rYUw7Z4MijWKVwWDa94RzF6vw?=
 =?us-ascii?Q?SqxSUmQ/QzsL53q6gXBnC6NswW/ugujUiUdcN94Z0w+MVcCjOaUy0W1qiJe6?=
 =?us-ascii?Q?wB2cwE7xduT12nM4S5crea3E7C+Ct8/6nB+D56RQdIiVlEC+wfnsLTj916YX?=
 =?us-ascii?Q?q2oKLL/VelkK+oHa3BHtfUhMXxRaAhI1pQgh10JFlT5RhO3fKHVNh9UsR0Ch?=
 =?us-ascii?Q?wtgpw2Gv/PGS08IhakYtBbmDE+94YI+nJAMTg8RYp+p8aFpw4EAG2u0uudY9?=
 =?us-ascii?Q?PSlka0dZRN5tGmxqVKt68l/tSWbTz9PiMVyw1kZsDIZ0D+obyd+9+srh6x9t?=
 =?us-ascii?Q?YpUi30bxl16UaVCF0Bqazm8PoA9CngtzjlCGLHqDs+tasZN+8ahM4djcUwS8?=
 =?us-ascii?Q?+NOdm4cKGdJZLvsiEmd33klyw2X71Uhc/cKGIOM+6Mv46rqUswKhGy+lvOgy?=
 =?us-ascii?Q?6ovC0i69BJXzwD93bG6YKm6mjHJ/7NZolH8BBnXq81w/6/txVnanBVjAL6NZ?=
 =?us-ascii?Q?Ldz+thAKlAQv2POFp0jK9XWgesF3UPvxahwzDVljjymWoVTUJb5rDzGOiFx5?=
 =?us-ascii?Q?FKREhChfWBmDc0MxFwNIZzg3KA8PNR1b/KtkoEDm+RaDpv15Gmi+26sUBUZ1?=
 =?us-ascii?Q?Rts9pnKW6FGi9kEEABWiLIG9C7t08384xnmfzH03tF6h8/Irrt4V6fsgQvC8?=
 =?us-ascii?Q?sdRnYFbCIs1CeKnBq3r7XseeW9KGZ5LkxkVaGrq5M8apNRQky2xw2ahyLxX6?=
 =?us-ascii?Q?SwHQGx4H9Kug5PykP/DFoBxOMxrt9l9a5MponmTm7shUpq/ZQwieDWbHAnEA?=
 =?us-ascii?Q?3amhcfAemL01Pad8FICvo2vfmVhSlCJT5i2RArwbOfJvGJ8RMP685CmcEX46?=
 =?us-ascii?Q?A+ByXMwi/SBmwBVGbe/IWBKPafuqe4by7tz0lowv74onlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SGr4KqYWLvVmskycRw2Zu2/B4htQuANhuFpN9LZfwoRa+Pc8ItCDgtWxgGdT?=
 =?us-ascii?Q?xxiB4yyda3SXcMtITTuo7nbl/gQFUwEn990fyyHXS7gB0k+7uF6sdhXeIMep?=
 =?us-ascii?Q?WeQnKk4ZIIsQKTa4ObmUXXDXvse44GkluxT56UnA2ZvKI1cIOXmC9vfsRhpp?=
 =?us-ascii?Q?8TgbgKC3Gg1oILSHxZ5+iLOOdmoHomTAeOTS4CUUeEzD2mr0jHj9WDjrPG6x?=
 =?us-ascii?Q?jhywcy4WI3n0fVhqUkrll50qhTWsEcSr0BprJB6WjmWjJE3ClukNbwX/4BeD?=
 =?us-ascii?Q?raqQbdhUIf9grMlHEHLak0G2iBsxtoXfrmrz7UHyVpQMa5RFSG/GUKfMpWDs?=
 =?us-ascii?Q?vxC4ZXA2ynszivGOW9KMsb+P4dFF56LnVYPDHjqJlv7Z0Uy47xJCpjlMEIMY?=
 =?us-ascii?Q?7ZEt9/Ox2rErkBxtpTKCFWsBvA/Vg5JwxPvqUvmfIyw3fI7bg1kYmEhqZ4pc?=
 =?us-ascii?Q?hq/tEuVVf85wgVOkoVRt8qvbOqipJJuRNl5YxXH0NEHGg1QK8M8h5Wx5tdCw?=
 =?us-ascii?Q?LGdDRIujsLDELA9YIIj6P0zSwhuz8HKOj2wX+vlk0kNzrMs+Tft3y/2Y8FyE?=
 =?us-ascii?Q?LhccxljcX6pzfv8JSP0+UFFtNdV5TR35drjhFeu4i0z44nQTuMMA6sKpktnb?=
 =?us-ascii?Q?PjNNscYctQMp0eXLYblLtOFi85fIlhDB18pOAGlUownufaqGtt2ER/Idd7Hj?=
 =?us-ascii?Q?uPNJ+Hb8Mi3mNa8/xiA9ZefeZ7hXuZ/DLUOSEduPS4jPsuQrWWFtWDlRe89g?=
 =?us-ascii?Q?FCxhxxB0WoBdkzMByOOhCrBxlDyJqYjNFhAhDRJlMmaV8WM4y5RfCA5zOHmt?=
 =?us-ascii?Q?e2ak0h3FqpTmQ6hMh6YSG0p/ZPXXKGNkCItjBw6tuAXl0TVZO9WNuOON/AU/?=
 =?us-ascii?Q?Yzi/AGXi9AcrT+nUdHfvbR3yLNVRaWvYIDQWGbFKRJGUGs+a0hZtsMSSoJH7?=
 =?us-ascii?Q?hPmEUrg4+aqn/zT3BvDaD4/9kGuwVUWL7nq8jOGBmWDYleTQUZ+Ngg18l939?=
 =?us-ascii?Q?Kj8EFnA/l/NWQSgYgYcZFWN9ss3ksvXeBCh6ZoGGu+Rg7KWPKxTLNARGfkRS?=
 =?us-ascii?Q?Y04ctCq4fJoYmdC9EijZnC3Kr8ZJx8hOXjqKb/UgpjYwcbytAuQoXollo5SK?=
 =?us-ascii?Q?EEiiDadJk4UOTg7bokYM6MTi6N5gtaLnn6Y315GxIuXeoDWNAs1IeaNAciw1?=
 =?us-ascii?Q?1WMWs1QwRXEWb+sBNn7ZtlIyoaYVQw7PqQ0dZvwMqt13qG7zZC5XvenhwcrU?=
 =?us-ascii?Q?va/a7dd/rNaQB+IL/h09Qh8eiA6YoGd9WNR0S9W8mYmZHgP5CrzTUTwvjn+1?=
 =?us-ascii?Q?/TmuyJSQb1blLiTdU8mESAdJnfxuoI9MBWR2iJhshy2kfFbgqLcYC9b3e5hg?=
 =?us-ascii?Q?Uu4rxIT+z6AsOh7vJTxmSoZMiGeIy57YCfqu9b8KsXCMQikptxkZBkNKIETQ?=
 =?us-ascii?Q?DcwO9uF1qZNkX1pxfII7LsW6NBaM4qYF62G3MvUKTzPvdPfYa6aiT5Zah+6W?=
 =?us-ascii?Q?7xpVUmiiJK6I2byaKszGNPkj+/sc3CcdqDSEO7zbnwP1fl2mdwnI15tkkTNY?=
 =?us-ascii?Q?FFoUS6KVUPkkMal+M3r9TSedUeb99zaJLsOgvP8Kn9N7TnnBrHyHpS3QQIR4?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d4fd75-caee-4cb2-f87c-08dca0531005
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:09:39.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IWu0pgH/TjPKrvYmT6Zry2hgMNoLlVY9P7vXUDKutHANrZRq2PN3ojJwIGWG0ZUBhi7dZaKtR8sMrjMgN3VEtVQLJIq68AZbs+Ei6O1CyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com

Greg KH wrote:
> On Mon, Jul 08, 2024 at 03:26:43PM -0700, Dan Williams wrote:
> > Enter the fwctl proposal [1]. From the CXL subsystem perspective it
> > looks like a long-term solution to the problem of managing expectations
> > between hardware vendors and mainline subsystems. It disclaims support
> > for the fast-path (data-plane) and is targeted at the long tail of
> > slow-path (config/debug plane) device-specific operations that are often
> > uninteresting to mainline.
> 
> That's not true at all, device-specific operations are very interesting
> to mainline, and I would argue that the "slow-path" is the most
> important thing for the kernel to manage as that is where the security
> and unification layers can be properly enforced.
> 
> Vendors that think the control plane should just be allowed to be
> accessed by userspace "blindly" are not saying outloud that they just
> want to circumvent the security layer entirely like they previously were
> doing by directly accessing /dev/mem which is one of the strongest
> reasons to keep enforcing this through the kernel as Christoph points
> out.
> 
> It's the cumulation of multiple vendors of semi-alike config paths that
> allow us to standardize them to provide the most important thing of all,
> a unified view to userspace where a user does not care about what type
> of hardware is running, which is really the goal of Linux as well, but
> directly goes against what a vendor wants to have happen.

100% agree and this is the argument I made for creating
tsm-report-configfs. What I meant by "config-plane" is something more
along the lines of an FPGA bitstream redefining device parameters that
get realized after a reset, less the in-band live-config-plane of a
device that is likely similar across a class of devices where the kernel
has a clear interest in mediating.

A fuzzier example is that CXL has commands like "read vendor debug log"
and I can see a device having specific control toggles to modify the
data the device dumps into that log. The expectation is the device
designer will put anything of general/kernel interest into other formal
telemetry commands. That "vendor debug log" command is trusted to not
have other kernel relevant side effects, it just facilitates debug
between end users and device manufacturers.

> > It sets expectations that the device must
> > advertise the effect of all commands so that the kernel can deploy
> > reasonable Kernel Lockdown policy, or otherwise require CAP_SYS_RAWIO
> > for commands that may affect user-data.
> 
> Yes, this is a good start, but it might still be too "vendor-specific"
> at this point in time.

This gets back to the trusted protocols point that Christoph raised. The
community has examples where this tension is resolved with negotiated
protocol concessions. The fwctl discussion has not progressed to the
protocol concessions phase.

> > It sets common expectations for
> > device designers, distribution maintainers, and kernel developers. It is
> > complimentary to the Linux-command path for operations that need deeper
> > kernel coordination.
> 
> Yes, it's a good start, BUT by circumventing the network control plane,
> the network driver maintainers rightfully are worried about this as
> their review comments seem to be ignored here.  The rest of us
> maintainers can't ignore that objection, sorry.

Hence a mediated discussion proposal because the on list debate has a
visible deficit of trust that email is unlikely to overcome.

