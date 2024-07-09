Return-Path: <linux-rdma+bounces-3780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6092C626
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08371F238B1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 22:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1380187870;
	Tue,  9 Jul 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkZz7Plg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A71B86D9;
	Tue,  9 Jul 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563321; cv=fail; b=q8BA+TW8hctqhU2yPmhi693R4uxYpEEDiC5kFgwXfa2alzHi3ezKSVWcZZKgvcIRvjIGcHauTe39yA3acWH7dyYreRVQMPd5dn/apcmXSddxIcQdsVqcawW9g3LA6NyWU5LnbhxZK9sl/NhFawlJ6Gzx+nnVmY/vIK/9jP8oPTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563321; c=relaxed/simple;
	bh=xQrqE0h3H0wIm3V7tWoWC+qcPsx8VmOJjHvs2dChHtw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k/a1Gn4gfA9qXIAq6X7LAj8ZqcWRox8IR3Xm/tSfS+5x1ssKv4SAcpPuZnDLQvO/ErJXT9ifgAyw8DwA7b9+aIJ7eJfZbasnnlX0AOfONaET3iCnY6ln24vqGx3KAiDCXHTY3SH0UERkKAfRNOLGeigHH/FY6HJUiMbdeabsR/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkZz7Plg; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720563319; x=1752099319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xQrqE0h3H0wIm3V7tWoWC+qcPsx8VmOJjHvs2dChHtw=;
  b=AkZz7Plg9Zxkd5bqP6Ok2eA2FPSL0a9LgZQSgn4BsZjbUAyggORk63+C
   Rge3LLxTe/4VBRmHPEGT1a1nr6U3NR/ExK9+dmdktmgymnEF3ekO1Rax+
   7BI3flGcMDH3stfrU6VdazJTFi0ZW886Ux8OzJ0WLkZIvaXL9OXSKXTxS
   RavzNSs2qcXIDNXkrnrRBJe0mssc4SW0ojGLIClcR2qvAy3E9TQnj822S
   RP8k5sBNA+5L2/9RIZsqdHJ3m9vqbfjI68jY7inqBSWR5TvwppQ+Au24V
   tVl8NTH8NI9f+glxZRVZRe7BX4nn460mxNVnJA9MR/t4hbdVml8Bq+IYq
   A==;
X-CSE-ConnectionGUID: ANHeKQ2OQGWsqoAHubwtTA==
X-CSE-MsgGUID: VcKp+EihQWaT/9WMNp/qZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17558169"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17558169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 15:15:19 -0700
X-CSE-ConnectionGUID: tOSIs7IeTMqCV354o0VkjQ==
X-CSE-MsgGUID: UosAF7yfRyGPWVl8uQYUdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="71225871"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 15:15:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 15:15:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 15:15:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 15:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DduFhe2MKtO03hWkL63O5leowesQ+m5gUs9+BK1tnMficcZiZx80DOViY5vGYY9M1BxrpvBB4qCExD5zbvm8YodLBPexUoxNzizn7Wu2DlJ/QuYV5Ca3J5fl+Egoklg4FJn+mUN5oH8sLPnFPovbgKIGPzr4J5HKpQT1DinVDVdmO++T+UpVEy9HWgvSKs4ixqSEuXKiFdUKua6UQ+sMLDx5id4PLvmY2YhpcGMxjShyVBhZbA2zDam7KZ5dNHzS4n2JDmokaYKYY+I9vnc+oSBJv+AkPICYgbPubc/llTy0V1WkTnKqZy1cTsX95ksZq7nPHl2axVS7iFhkvrXD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB90T1SVaWsoc46+1rY9/RnMAHAwc7j6oWr5P9P2yko=;
 b=WeX6/9WX2Fl601jR75GK9HTB/LlTam6BRVXNNuqlVMhSKP5TXJ9hfj9hVhC0eOx6sGYvTRO15wqxq26wSxa0EWYXIMiyUpCWBwlVCgjQLlgUvgGkuCau9CEgjDzyjm/y8s76HaSNxAWvpEtRGJ9b/NK3XnypVoJp/O1LAXxRN9ZMVZVa0Y/s2SbQ4btRrDyQK0gHDeiWBscDchyeWeLHABh+zfuJc/L8UKrbeO2Gpk7YkVg5h3Ydo1pXhPBU/K/kSzYJVToGcFO4l5dwkgRdbioL5BdLi066X2ppb21d98ReXY33oiXbbvUfAUbKwBj1Ppl2FcrpFgxwl9hyFr2XnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 22:15:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 22:15:15 +0000
Date: Tue, 9 Jul 2024 15:15:13 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, <ksummit@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <jgg@nvidia.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:303:83::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d253541-f7e5-4ef8-1c22-08dca0649c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6q/If2kLXjvAepu55qfw4YSwMYxNUUBIQEPfeqc3uF5rgXMP6K1GjJkR2UDV?=
 =?us-ascii?Q?ToDMO/zmczkn2L6m00vfiBt6USidLbIY4vrVQrhz3153EmNsie5XSv2OOnfi?=
 =?us-ascii?Q?PhlioJ9uz65ho7QYQqWKsLlikT8y72m0dlqLVYVVrARO/5LBjQoPDeMBW0AR?=
 =?us-ascii?Q?HePiyujArCtJpqyROPY03TA5JsO0rA8fyZ9jjBMknQyXaxGAeS1FCgeB5Rzm?=
 =?us-ascii?Q?c63p3clIWMF5MppVy/Uo++cC101He3hxU2h5cei2QCu81D38CKigzURD9fF/?=
 =?us-ascii?Q?V3B8uhIpc9311XNPxBw3sm8s9DrvrfNSF+fNIu4MqUQanW70o7U2X83QKfbc?=
 =?us-ascii?Q?8HhAkPN5d5llHxHNOAojeQ1QmLN2FZICR3tPFqgRnasQ6TYo0RP4fi17vVx4?=
 =?us-ascii?Q?CQLglwAz0H4nsto7ZB+kOfGooFOBO8FGjuDgbA9/VoqF6kBZsC+XvJmpGHBg?=
 =?us-ascii?Q?XeNiRLl8Kt0stdX4s2tFekibMHcqhJnGeRIcU4RMGWoP9w1qEIcAkNt0drt3?=
 =?us-ascii?Q?0yWiD4a1w1CMlg4ojze1LyuPUM2niUzhdFR1fMr6BiBBqMvDJCE6yii2dfbx?=
 =?us-ascii?Q?UtT1kvGOqM8LFDwVcbTZtIQP+4iqKhbG0V0+f4USkRV6yp9x5IGlAFf6j9vR?=
 =?us-ascii?Q?tyBwqzmt6VLcSJ3T2LIaD9ibj42fHVpQPQAbiWIUNNiBUQCuHcpykYagzm1z?=
 =?us-ascii?Q?5CtRL8G53hZWjKJ86oxZTHBsJ6qMoceQmde4Bdjmw6m2cq0zVYJiZ4RTLj3n?=
 =?us-ascii?Q?WnBwUT1ZOddlpExHNxmZuEs626Jc+oac3fCMfODCMCDVAsMz/Z4bld2kRSVT?=
 =?us-ascii?Q?3W99W0rwxMhehe5FCBnK9kjAO4Du7MqoEWBL6gKPUIIoqANNdXTKFh66956w?=
 =?us-ascii?Q?zew2pmffqw5dvxOsuJQOp0rabHIVcaPG7A/VMHmxoawHh9+CL1ba1D36ufK1?=
 =?us-ascii?Q?dI8OScryhTVnp5B44c+2dKAxNKOCLj4KNZnVfP8TGaZk2MqQ+FYXmQHrw1MX?=
 =?us-ascii?Q?4JhfALm+r4jWqPC+v4gcdEgdawCPwc3d29UhqvSwqcaCP2XUzCCP8a82pRDh?=
 =?us-ascii?Q?sk3GZlvTrdQMtw2miewhOXp89xd6rGG0knX0oGcQfLEyB5SXr+J6D1KnfSiW?=
 =?us-ascii?Q?Fu1qq6CvT4cEkZJJAilFSgkAlyQsJ8oSCWglFnkkMCKGf+D/NrZhIn4RoBIN?=
 =?us-ascii?Q?KZ2UYpsXBN9t5FNiHIf/2de8p9OVMc65gqE5R4AhhIxr5zPvp/7HK5g/K0ok?=
 =?us-ascii?Q?1ZAVgLagtWOiEAz2EdHZcDZIM3Aj2noXi9cWvDLP2NBc6JYz17Gbk0h5rNCk?=
 =?us-ascii?Q?3lk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdi9RK67KLwwICDCl6iW5ZzCh3kZSyaaG5b8hV0mrH+SyNQ5iAjuArTkwU7N?=
 =?us-ascii?Q?qam2BjW4nO2jDbtl5vq3i3FnCWrpTqRhCh68rXwCpuZyKUYrp6xHa9Yfa6nf?=
 =?us-ascii?Q?wxnCbe1ddZp17/f3q8lL+JeOCieAwRsdLr0rSyUmpTSKsfZW/OF+ni8xeV6J?=
 =?us-ascii?Q?nhqGWCdIOSBdfIrr1Mv5oB6QLLS41yd/016RPoElfZmbbQfqb9HUlCr8+ErJ?=
 =?us-ascii?Q?umK9K8PqILAx7IgZlfZF17gorVS1KiPp5j+uGobzHjP8er6/zJRn/I3DUZ9J?=
 =?us-ascii?Q?Lx5cqHHmT+beoq+18T1XpnQnlVAbCOCZ/EOnWMJ4Bk/RETbwDdSyzlWREsTc?=
 =?us-ascii?Q?3SYe5YZdBOJV8HWF+7cpviUaqflOvmwgkBvwGxh1fWS0QoetyOY+Uvtn0tWx?=
 =?us-ascii?Q?t5VbeLcLwELyJdFtguL/tsjpPyGLk/3Zn2XxZIzmWAvGU54PKLXFolxM40iS?=
 =?us-ascii?Q?XKJiRdCep8/033ys8FR+E8cmgoLGgaoFmeyW+eN96pNwga8+OCdR8jol2Ovm?=
 =?us-ascii?Q?e0mySAEbLeoMW6dotlJaQsex2OONWPN61YC9j5l8PT0VFjbWnAPwdyG2WWwv?=
 =?us-ascii?Q?aFV1f4gp83uHO3maQeQDyWsRe9M2Mm6vEQw0WByCpLW/7Gt5A4XwZF25UlJ7?=
 =?us-ascii?Q?0ssO7ee0SPC7tM6SZXVSxs5L27NxHaAQDgvWZWvl6pLP/a+ECRgOYz3wtjOo?=
 =?us-ascii?Q?7lbv7f/33oF1tSQJP5MkYHejx4RP5UhvNEOkEU35wZ1n8gdgJzgTUJH+2/Hx?=
 =?us-ascii?Q?Ex1ZlerWZrTmwWrq8NYk4gGqxdmD0Kz0J+z09xIl28xPaqKrj5yKXBpL3G2K?=
 =?us-ascii?Q?QwUZE1A4J5wz5CkEDkyY42J9fsoSuJ/uvgBt3GB3NhMWscdQVukALxLmBg6c?=
 =?us-ascii?Q?dlNPzDBJwJnEeLaKU9oJnuQyyY5ebfmJQXevQOeN5gZM79hywskiQX0dW8aO?=
 =?us-ascii?Q?8kJZMhlQEoqW3zKVPAE07PxE2KdgAqxMup9wdYrkI+L0wO+OIX+bacNHBRmx?=
 =?us-ascii?Q?GD+d8UV5kpEBLfYej/PuUKrCamxqY40l0ZCAufq7KDu2PPHQHPaymZ9Aoia8?=
 =?us-ascii?Q?pPLgZtxLsez+Bw1uTJ000yilhyFFwepQR4qJJ6yTpskeZ5i3W6Z4nPq5MaS+?=
 =?us-ascii?Q?U3fr82x8XJV6GwvrUjLnkiu3w3mRyEsC6+0vHT8Hne2DC2e/jqjV35u7drQ8?=
 =?us-ascii?Q?al4ij8RPN9nFFvhUoQoHBtXALPDk5g0VedM0KnS3pLB3XefvE6VMlCzN2Kcl?=
 =?us-ascii?Q?p0/iKYy8x3QDoNBK5Hfxt+ireUp+MPp0rMH7bD66lVkMzmVHH7qxmsehATuV?=
 =?us-ascii?Q?/+jcMrZ/MHpsCbWO74O9NSXWC5Pd/px9WcNHwEIFdc3VCXhOAHyqwoGuFRqZ?=
 =?us-ascii?Q?6K69CDqNlzBmm43fNQ/TltU2zt9m+AEikSqtS1yu+dyvoWXX2q6HruVpQ3oI?=
 =?us-ascii?Q?Imqr594dOc70BOzXx1ndeLXanFiTPnji/CmenCEktwQ9PMGDUr8JifuUZFjB?=
 =?us-ascii?Q?e0Sipas3i11gaEh+DBpAGjcCdaVEdyMYYJvpHdzsfkGlMbP41Scqx1oIWEmX?=
 =?us-ascii?Q?qd9LDoEBXStLTpkwejWhrkk7voDnnX16bYzaPCXgYL1D9sLKfAo08kQQjuLh?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d253541-f7e5-4ef8-1c22-08dca0649c19
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 22:15:15.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtuBp3nrwGFoAKrH+0YLalzRpR8ce00e8+N5xJfvAgXbYcm9o5YOPnRPlHAks1bhxklIx3pT3W3iaYy8qdEn2/QGpyFsr54wqL0yt6G1vto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

James Bottomley wrote:
> > The upstream discussion has yielded the full spectrum of positions on
> > device specific functionality, and it is a topic that needs cross-
> > kernel consensus as hardware increasingly spans cross-subsystem
> > concerns. Please consider it for a Maintainers Summit discussion.
> 
> I'm with Greg on this ... can you point to some of the contrary
> positions?

This thread has that discussion:

http://lore.kernel.org/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com

I do not want to speak for others on the saliency of their points, all I
can say is that the contrary positions have so far not moved me to drop
consideration of fwctl for CXL.

Where CXL has a Command Effects Log that is a reasonable protocol for
making decisions about opaque command codes, and that CXL already has a
few years of experience with the commands that *do* need a Linux-command
wrapper.

Some open questions from that thread are: what does it mean for the fate
of a proposal if one subsystem Acks the ABI and another Naks it for a
device that crosses subsystem functionality? Would a cynical hardware
response just lead to plumbing an NVME admin queue, or CXL mailbox to
get device-specific commands past another subsystem's objection?

My reconsideration of the "debug-build only" policy for CXL
device-specific commands was influenced by a conversation with a distro
developer where they asserted, paraphrasing: "at what point is a device
vendor incentivized to ship an out-of-tree module just to restore their
passthrough functionality?. At that point upstream has lost out on
collaboration and distro kernel ABI has gained another out-of-tree
consumer."

So the tension is healthy, but it has diminishing returns past a certain
point.

