Return-Path: <linux-rdma+bounces-1432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C787BC38
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054C41C219A1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 11:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFB6F071;
	Thu, 14 Mar 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvqHnTkg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B3433C0;
	Thu, 14 Mar 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417111; cv=fail; b=cgWhsYMs3iu6k4lNsleggDGVoGo+vf4Jz7BNRnI5ZH/R8xvAHjPhuYmEnhN+TRmpDTrz7vY9l1SjQyCiJxaNHq3nKFK1zsiS5HBDpHUc7QQGSqX4kIHBTQiiCTOAj7bR0XJicNM/RjqfjVInWzZO6AdzdvOAihIs7aJB9Bn3h4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417111; c=relaxed/simple;
	bh=OkU7EzNYlneAJ+Px/modPamXredhA8MzNHq4VCF6Lx0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fldvLDu6at1Ju3UmZXg3Bt82Ym2V+WspGxYHYnT7JGBW2aezg2obA+IY6hGfR4lg72Jqo+ENPgcO0ddcp88Ow3o4TnWqDwjqUyQfiZZrQAy0Jr/5XA4ur5rIvkxQE+HrvSk8V38DRkLU1zOBwhWRr0tQ4zmPMp78rbcWNu1P7eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvqHnTkg; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710417109; x=1741953109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OkU7EzNYlneAJ+Px/modPamXredhA8MzNHq4VCF6Lx0=;
  b=BvqHnTkgXrD3zNpkRjdkn8W5lWgTCoa9NndLXLpk0rqFZ7UnW5lfVRZE
   Ht+Y/mlFUcizboyz7/Sfl6jmP9LGFAWyoR9BJg2C9ZbiTr/3UAHyOj9nc
   l6AMaEtLRXlI2K6tXtm1kNUzaIdxH3rAiMD5asgkDxBWw+8HROvEkzQPX
   LsjcIvHPR3e6CtXnRsW8KaQCFwAfIz+/bWYn83XQVR9iGtqOGCwkZzn+c
   j3/6Fc9CqFgIdGlolAhSKMpNJRQCPAWMy1kzVcLcyzo0QJqQRHDmSbssA
   DWd7KTplO/F15ESVKoCdfeu0ATXuZ2VsODapxRRuwqLdcpkFhseVEEQqe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5095130"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5095130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="16858374"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 04:51:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 04:51:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 04:51:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 04:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob1vsUN8osJ/vxoHeIf/MUwpGbERLJUv+2vB8fARtVJb9KoyAcjwon7x9NoUPhzUmXEOYGmDa7InjFYSeNgq+vI0PYwXyIpRuBvtruRe0JxGoxXZbqxJ2yjgp6krwFTabgNAo7sy2c8drJyelXJ3wCS3ANwRTVZ4nubAtdgHn1HN7hLGBvuXK2oxTUNpdrh42Be9r/KYBbLunVhSySNlNp363XHIWQ4eJqoQNmRoiAbP11SQNpqrZOVP8gpc2W60NEKNWIJxrhVq6COBE5o2MjKwGgW8jXR/6Wm5RG7/oyqjKXCUTvun4zTqmqrdXD3kQKD3qjtVjGqg8UfEEcFazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zia3HH8SgjS2JSQ22l3TYlNDx4o6QdVKwkyzm/11VPM=;
 b=RFmh4WxtCnevUsyqB5j6UyNWLxq7cscTw7huZfU2VLZfoYPFeV/+xHepAkMbwBJCmHavfRNm2whM2itslu+HuLKgWDrHFMgHjys4CuMw0vFrjazGPNJkl862LLePOVQVf/bJqaxyXTRvtgjp3D8MWBjZ76WsEyJj+lIEMh3olhuJznF1b2x0ZUj/FJ8vsND6gEGeoCab+lV83S//tDBtx0L2duRwRfvwfi4nEtadchsDHbKUVq1r73xrD3wXOKPcJjhKAycWanncvB95iGIwXn1jUTTUo7R6LUZU+OvVsw5LAuJ0zfA4EhXUi1aDeqv3X8wSgC6cjjzqyH8fR3HJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Thu, 14 Mar
 2024 11:51:46 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 11:51:46 +0000
Date: Thu, 14 Mar 2024 12:51:38 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Yewon Choi <woni9911@gmail.com>
CC: Allison Henderson <allison.henderson@oracle.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-kernel@vger.kernel.org>, "Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: [PATCH net] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Message-ID: <ZfLkyiTssYD8wmVl@localhost.localdomain>
References: <ZfLdv5DZvBg0wajJ@libra05>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfLdv5DZvBg0wajJ@libra05>
X-ClientProxiedBy: DB9PR02CA0017.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::22) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d882e83-b62b-4995-a191-08dc441d2045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtJV+e+kh/QzN+JQYq9dymVFZ9fPos2CGYsdSc8blLexWjUCPapPxTot7n5lm+rjaTpRHF2ub/OtUyNn5DSFB7D3QQmAZqCLiaXhtaSYKn12sJTpxsmkQ7xf+aWZ1G1d+UTw/+sf+aMXYtqkNWDOdLi2ft5uqHwNFtx5Fya1nlVjk4dEpcfA5lQDqqmhY+IJvtT8tYAXr9uHOBDbMKAjLNlRUhGY+xK29EQawK49pwaBLo3792170yBSAMDje/uz80AkGfM4augaLePDFoHQKP+LCr2RTTUrNuyeITiK0YAsqePxfq27HXtfuKTG5UXDqhCV42VGA1HkhbHjkZIs8fFd2cYaAd0Zh6Ke9cdjRcTGm/33LvaWoEJJXbkw9A5da9WTgfY9Acu6yKsP8G4hnMidNaBR/HcGr5P70gAoUC92UIwN5c3vyBFE2vpKppXOD+437Pt8H38asnY2pznFycxTHBQOtNYt6cWKmw+jmhnKMfxI8PA/7t6kgHAvTHvlKQODOKdrQ/1NVeorvPcyDz6FF6Z1HwIzIjBRNSGsm9icCHBvANju1n1XQK12QBZblhJOQOLBC+VqVGeoIwS9sqs6WNKYUasxS7VvwuqJ18ewklzT5KrABfZwzxUBA3dyC0mDY+Kx/oPvySPYZ2AFUkzhnfuHRzY0xnkhWBjTtdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lr8Zf37Y+GbER6Ko62LkdTSuiJhB+iylRcYPF+iYRA69jIKduD5mrzX+nApY?=
 =?us-ascii?Q?6s/PSt7+KRm2XoC7Q7c4AUU7CYG13xZ8mRtzPYGqUBuAC3e4EXxf975wp9e+?=
 =?us-ascii?Q?ZUgm6NxDhK8e3w7JUHGWwWxaWqxO64v5eTmjwUXmlptD3BsCAOu6aIjpG9Ha?=
 =?us-ascii?Q?CfzNj+Oa9BX/BqXkoFMv7R7Bxf/yLLiw8OKmsNZ8AU19uE1NHeLtkDCXKf38?=
 =?us-ascii?Q?fwjrKYtMEPw+HJ5wfWErNu/CCJASDin1a01X2v4lBZEF/mAr1DUJ90+gZcyy?=
 =?us-ascii?Q?2DNI8tpByS8aGQSXxPIcKnXWCKTF+AVnLfH9zdgy0Oj2+11Bi+PjjjuF9ZSl?=
 =?us-ascii?Q?0Lo6VROgfHxCBWPrqLHzuHgMi3312aA+AgyLKo2FK98HHPG3A727jU70BgUS?=
 =?us-ascii?Q?qBtTfPWHGi/stAbIrXVrfK/gwJExs0SbruZ8Sk4yTDMIsaV0za/HQ70PICog?=
 =?us-ascii?Q?aYApbmWeoaiMPKROTIx9euhktQb8VdOR5JG3ZnWjSxCznepKHdKKFpsdXogV?=
 =?us-ascii?Q?zoIm68jg9i0kJYx6ApZUJ/mfpEAwpLvHr7UT7/5uVj7AyRMPXMFhVZgsDXbg?=
 =?us-ascii?Q?2AUb+VuVft82Vy76F8qM/TPkjVBmuaAx/3d7/1YPkZZVg2qBGLoy2NLtUnWV?=
 =?us-ascii?Q?cc0EjH7e2bsWU6M1RX+gWG2a7CxfGtlF7dyHVMJu8uzB+u0qFvpzgZR73DjK?=
 =?us-ascii?Q?eX70gwuW2wNiSBA+FaIXnfrx3b+LrE+P/DxK1BKoZPYcJDqy1GNuRuuE4Rsg?=
 =?us-ascii?Q?6K/htWk1IsTPbIdrfFXD1askE2wlDbwX3D0G5EmNb1PFj8LZ+prmRPPsrUQW?=
 =?us-ascii?Q?RIF/IYsDT+Th5sTpI62rOXGzB7yLMoqisf4TV15kyjM22jJ4B3GkKIPLL/zt?=
 =?us-ascii?Q?PPCXcVXQDwdo3xqHi+7sxEzHqyVU5mT/KBL4+9AQ4Vw2c4L00myU7tzB/kox?=
 =?us-ascii?Q?BFd8CsQfEO4tX/gEFBTwDPQ7I4MC0fgDh+slD94FE5PY6ZMU3Z+SGFuXCVXV?=
 =?us-ascii?Q?zT6pE/fS41AcV0CJ9Qkzsz6Ln75VoSQslQ+Nglwy2fmTxgF4KDyvt8PSRSzc?=
 =?us-ascii?Q?SkCbmOm+zmP0oOuUlDPlXIkh7MWiUiReWdMQ4TU3GreU9RwEUVe5RF7x+wLu?=
 =?us-ascii?Q?UR8T7Z4EGEUlvUqhXYf9aGL+Vjx+sN72cvpEk/PEVU7E8etHC4BTt5V+Fd6z?=
 =?us-ascii?Q?GZLw6uMCJaU4T6XSrlLbAqa05XLmXjvTbGKOUQZnzwzx5Uj64F+9R+9sbRjF?=
 =?us-ascii?Q?gNQdE+hWbFEnZkzG5cI7fRwAZ8c7WDKP0Ll/4BGXwDRkkaAKxctuWPchinhb?=
 =?us-ascii?Q?ixo8Kal83PNt5qBFHM8uCFRwtGSxOqVwvy42Xi9JSfjXaQIjrx8w+u3oG4uW?=
 =?us-ascii?Q?zczGxDq6U5HiAg7ux1fpTH+byPR2tj2McX1FQS2oM9If8zD38c/clkMOpAO3?=
 =?us-ascii?Q?6dk9D/a6rXB+Rvw4fU7p/HSFZ0345NIGqGOjbwzkI4LOAD7rzBCmYM1reuJR?=
 =?us-ascii?Q?7SjEIFcD6LTIEfis+SlESeP0B0QKcZYk4/C00EWlsxnR+jmll6Bbp8ggdfeD?=
 =?us-ascii?Q?i4O5IjuMLxsCFD14jEa5iduRWFx6KyJII6e3wUhc8Ex7ajzg4C/45jqkRKte?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d882e83-b62b-4995-a191-08dc441d2045
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:51:46.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANVjut8oPJoAy6vtJ9k/csV0yC91YF0HVQz26OrK/91l3szgOUgVpaS1T268wmR4++8//U1we4ZE2NdlYVSk4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com

On Thu, Mar 14, 2024 at 08:21:35PM +0900, Yewon Choi wrote:
> acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
> are expected to ensure acquire/release memory ordering semantics.
> However, test_and_set_bit/clear_bit() don't imply such semantics, on
> top of this, following smp_mb__after_atomic() does not guarantee release
> ordering (memory barrier actually should be placed before clear_bit()).
> 
> Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.
> 
> Signed-off-by: Yewon Choi <woni9911@gmail.com>

Missing "Fixes" tag for the patch addressed to the "net" tree.

Thanks,
Michal


