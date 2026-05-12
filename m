Return-Path: <linux-rdma+bounces-20444-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ+xD3yHAmpXuAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20444-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:50:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D051E51876F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE0A306D41A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273032836E;
	Tue, 12 May 2026 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e8kyPvBH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05917083C;
	Tue, 12 May 2026 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.245.243.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550219; cv=fail; b=Lb68j1TAej/BsYH9xJA8fm/6u3yuXPAiXRvJPjyHaMcnoH+LPDLnGbDHOIqJnofR+nh0ctNhjysntCeRJZke9ItXsWxWFnmpiG0SzVp4nSFyrhvXnWSJxEUXuIyfQMdiYCFsSrHzanHfjl5bNXQSHM3mZ9N/1Dl9IVTY2iBoqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550219; c=relaxed/simple;
	bh=XjimCataUWhMP/iiXqUEAmNOTKRATM27ElmPPRWsKEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i/CIMMiY3d1HJwU9BfqlHmjUo4nVZ+suisHSaqQSTWvmdObodN9IVu6iT2P25lCl5fLI76sHSc6jFaFdov2TqUn7LW6+bQ8YptF9w7KxfjtsXuRMKMEduUvFkLCdswtLBCNnlXcNcvQzeBkMuKS4NbaoRd5BVKS9ajw/M082Zq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e8kyPvBH; arc=fail smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778550218; x=1810086218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TgrQoptPJOMk+3/YelMlT6lw1IIjms0D7V4QLjQBSjc=;
  b=e8kyPvBH6K16FTvuQ37qCJHTPdzvDkmEu2n3tosLaxEXWqvYW9uMm2Oe
   CHch8MCq2DhLeDaKbzBBqjUDQqpG50adeo8mGE7ifxUZt0/MXFJGhf9oH
   nlolFKtsF5jClJXUzpykscRZyZxtnNMruyQ4h1yTSSy20xhg/kXCCc1SB
   kYliNn4nNI3cozdjk+E7zc2ONfmAWEFKTHTbL3yOFl1cxZ0bf8957addV
   azSAmQLIjHH2K/wH06dqulZddxD7Byflo/SFke97ZS35onSmHsOdvYu4g
   yP9BScc3K5A5V2F7dWdXjtq7meoz+Xz0Mm1VEQcTfB5LJPxQW4sNKzres
   g==;
X-CSE-ConnectionGUID: qC2jb7K2QGut8SWrKzXYuw==
X-CSE-MsgGUID: 2kSRl48ZRlad9m8p1wbS7Q==
X-IronPort-AV: E=Sophos;i="6.23,230,1770595200"; 
   d="scan'208";a="18918472"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:43:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.42:2525] with esmtp (Farcaster)
 id 16f33058-11ea-4cce-a63f-f86883926c34; Tue, 12 May 2026 01:43:35 +0000 (UTC)
X-Farcaster-Flow-ID: 16f33058-11ea-4cce-a63f-f86883926c34
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 01:43:29 +0000
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 01:43:28 +0000
Received: from PH0PR07CU006.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Tue, 12 May 2026 01:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDEw4qLzs+c2ZLeuR2btJwJJ8YxWr3VjOQYy8DS4iGGoJzwtbqIdDGFoywCZWfeK8P6gLyuUek0p7c7kakMU6xlv3z0N9YojLLcQvyCKZI6NgiK0WCUWxoeMB9tfcfMLGzqqAm6Eqhsa8GGf/QVpIi9MhW+Uwobbdx3EjmcZpfgEVOLXhkGHtcitm6YSBChNQZsoqzj6zIebuti8b9hApD3DQvKJ949w2WT8kihvkwsef5cyDERTbM8yXmeX1eoGO0r+TqQj52o7r7VnehL6XVNdNmS/nRgoScAUd5d99selpV/A9WmNpeWXMCW5HTrRQkCvUiQBTo87TnkzNNvrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgrQoptPJOMk+3/YelMlT6lw1IIjms0D7V4QLjQBSjc=;
 b=EUwsrmyC088MeZkSoEqRquI3oslAmj9w6nTAAC6atu/aY3B2E9Bx+J+GXsX0CGtM/kkF5S+8j5Nc89XsMP8zLTp8jtrgFWGAVxheFEUbTBU7K5noA/D51JTemUZOewYfB3zN4k9o8Ry2baTEgXNVybRlltjHVTpcsEu9D+jotNJvIPWFwnjv4gfJV9b7vbBivzEpFFAm5zJnin6FhaRPw31v8E7QFylLCL7rbNM+DISAL4o0iwyIKNQ9q30uu0IqWWcSudPwIrTuTT6iYx6AG2TMQ5rrHcfN3Lbc+t5xF/ahmv462Pn8kCRJfnofVeQq3xa+9l7+7HruQulCjs0USg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by SJ0PR18MB3900.namprd18.prod.outlook.com (2603:10b6:a03:2e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 01:43:25 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.20.9846.016; Tue, 12 May 2026
 01:43:25 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "oss-drivers@corigine.com"
	<oss-drivers@corigine.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>, "Arinzon, David"
	<darinzon@amazon.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"idosch@nvidia.com" <idosch@nvidia.com>, "ivecera@redhat.com"
	<ivecera@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"kuba@kernel.org" <kuba@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>, "petrm@nvidia.com"
	<petrm@nvidia.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH v13 net-next 3/9] devlink: pass param values by pointer
Thread-Topic: [PATCH v13 net-next 3/9] devlink: pass param values by pointer
Thread-Index: AQHc4bCzty6BSnkPh02DvKlZIBfR/g==
Date: Tue, 12 May 2026 01:43:14 +0000
Deferred-Delivery: Tue, 12 May 2026 01:42:21 +0000
Message-ID: <SA1PR18MB4664A2B6D163D6D694AD7780D9392@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-4-rkannoth@marvell.com>
In-Reply-To: <20260511033923.1301976-4-rkannoth@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|SJ0PR18MB3900:EE_
x-ms-office365-filtering-correlation-id: 1ea65398-138e-4af6-3a86-08deafc7dbe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|3023799003|11063799003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: SEwDbJWUoP+VPQx1LXmvwd0jyU/DE5nYeolX/DPiWzWxD3QPWb1rjkNUstx/U01kbcLh/ytRfJSpsy4ifHl8aYhvyTmSgvnFxthBL+OWjBlNExmpKIS845rOLwQrQPYN02iS5ofxYhip84djezdup1aCcZ9sTRTSVkSufurDOrRhPUOa0fpxvmBbBosH2Umhy/ETmg77QUPpcHZE/syqVqulpCrga70EQssHdkyP9lm14CfM9u5cWL5O5GV3p2GaUcQ4bmVqFQIw1zOjORKkWMNBv2rT4uR1oVA6xZSNEN605hJstoNGgOp4taodcjzZGGD2qGZqdafgRHISwKGg8EIYd5QYHd9RhTspC2itOO/+/4hlxZQ7Sj12ZevZEaAJCCv03MgfVsn072TaU+QEmQhTvg657PxFXGnQBCVWzPSgZF9ww9V8KKsGysX152bAWdjyJBeUTPnxP78bLWJhSBz3X5w2xmmIDa6PkOEU1NYwBzm7tKlOTmmQXkCDbiU/86mjRySUI24cEvEygtuynNUrL6clG6+hMZ1zAsF0PGjjKcFyqtoZgAbIdaUroMvnGlNoeqdg6fJA/jD2jWaV244PrvWLtrP+JYnfotKc+9YJaavENi0ypjP0Gh6VZqvWntjxRpf7mLks5G88AKSPb+fm1ZjHWOkpXZ8CmuTf3bfeuBHqBqmdPVyOSGvGhAVxxKbNrWZUx6aZ+Xyaj40GnSBangCsPsjHwce1JMmduL8GjT17jE9wE1BFW0qs/KBW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(3023799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wDJ10dr9g2TPlwcvp7x3kMVBd12J0RmyGgFYjYuy7HtVSXgDxVLBgHSjpfbW?=
 =?us-ascii?Q?HAv0C35e6OYhlkThBQmkhqksXeJWWE33fxq09jkWxJ65rFrds4NRkoRgLJPf?=
 =?us-ascii?Q?DSYFhZB1kC1fXSJwt/4e3tISVhOw/zu4Q4DSGomRJmHsOMuxYfHiEwTI1rfB?=
 =?us-ascii?Q?BkYJCTLR6rH3s9wYVYvVVHx5xnvpJj9svUQOvZJ2qsIp2sx8qGwJy5Hfj4D8?=
 =?us-ascii?Q?xv044jmnU37Q5+6rH6V8GG+uNpMGgo7QHB+636apiafmG228BzOCGJUCeHYp?=
 =?us-ascii?Q?X+cJ27XpOuPBnAi4qcxZnfg2kp3axHPtNjeifrPEhjBeZhgO5uB+XevFAs+J?=
 =?us-ascii?Q?yVLqJGUiwewDXcRexOtfN0sBENiI8F4K5zM41b1+Ee2uwrnmDFn7WfkX8hDJ?=
 =?us-ascii?Q?gK62BkfHy0+2U0wO5EziH/l4/UugqBHDvh7OY7h4soZ/SUZk/HTO6ouXFaKs?=
 =?us-ascii?Q?K/8b7NH+n9UsQh//KJ3aF8gHobBdRkxddX7wBbOXOKwGPXP5BBg+KdZqrVWJ?=
 =?us-ascii?Q?hryWWUI6TOKMm6j1nCxY8H6oHUAoKnFxTljOLCfhL9SWn05LSaeKoiNwraH8?=
 =?us-ascii?Q?Es7Ca+khqHt4f7Zf1gWFToMr+YiBwxHUTGOGdTor+m0oZwjoBCMY1uEHOsY3?=
 =?us-ascii?Q?kuVbKMDAsqIYdvoQpXf/vqMDRpUf2ht9+rquvH2o0dRqCzVXxRwA5n7M+Lg3?=
 =?us-ascii?Q?mOiBsCNviZ02CouwyZANi79VqJ6jc75R8ILd+hTUnPtdZczkibfaYN6JOTyZ?=
 =?us-ascii?Q?Md93l5+wV4Tv/ZMuRzzC5rIAYiETDxL3mXF0xYGagpQcVXTuKCYOtf+jwEWz?=
 =?us-ascii?Q?cXc9KREE2Xqn4Emnuuu3BPbyCGxLnqiTzuCwfDlYAcf79jVYjGjUIDPuYCZY?=
 =?us-ascii?Q?rjdTep4SctQS4tWQ+07NB7WNM1hV4IKMYM6efjKtuFq12gSgUtfyWxT7KCwF?=
 =?us-ascii?Q?EZKknPu30keJG38ECT4MdLllg7zHk2PvV6aUgILEkTsb21n2qVtxLWN9ozxL?=
 =?us-ascii?Q?4b9yPYExeIMVbd7fBdLeZVfyWtlq6DivKjvGzQOLE5pfrU7j1OrjVN1xJZgr?=
 =?us-ascii?Q?hSr8Yp/AQUQLrh+CNasRGteupayE5+Y0lRNs1cRrGRbfnRCEa/LFE2eev3Wn?=
 =?us-ascii?Q?Lqn3AXez677N+ktuUoWECFkiCaly29CQHWkwMQNwlxNlwHxlcp+mpHbFzxOz?=
 =?us-ascii?Q?4x6QBM1/havDb6iompn5VuMm5qzA8GatMTPWv81isBy7K5SLwHXqOUXobyt3?=
 =?us-ascii?Q?lMe2pOYdUQgig8TsnWY2KNvqaG52VyR8g3fb63AS7sUYQqf5exYNtd+lManb?=
 =?us-ascii?Q?5hM7An3uzwK65WWwRJMS0q8i9nSqoxUgLR3MK6/hKTGgTD9AkWbNgkSVJ4Wx?=
 =?us-ascii?Q?AByccYrfPP4T8/h8qyNoRaC52Cjoh3QSrJbH3ccZqMtJh2gTIiAAyT1JPAZv?=
 =?us-ascii?Q?cFKP+1dfDpVUe9LnhCRmAmrVaZCK4oKrDftci0I+dOOuMW2HWpu8zhDmbMTv?=
 =?us-ascii?Q?ti6dP+V5Gtowix/9MQG1gFllY5egHZ6EKxkJnBLb9S/plmW/RMtTDnrUdDV5?=
 =?us-ascii?Q?9WA5wMc49lSHmphQnEwyjF3Pp1SitxzT7VuoVb6lQ4cufF7hW/e3PyMHngIh?=
 =?us-ascii?Q?ipL0PuO+MuFM7bM5H8FMrvZgafL4izjvlBvuNtupFhiF17/R7Dt+rQSzLKSV?=
 =?us-ascii?Q?WJ6PgZ2zP2Yo6uBDO9pm2TEFgijvJCK6PpL34fpkCEDHaHhTEpGWpBnDSVuz?=
 =?us-ascii?Q?V4oijPdd0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G4LdJ1q8ExgJ5THUiCKnVM8S02g5haO+eePB3dzMzRmtDPb+1zjBnxJwswP77wSfk/eq1ymaJD9fFvKDeBKQ2xCt4N4Ol2EFhOedQIunJCiePOgCozbPXlfq1+5b/+Yp71J1Pjxch+Eb8iTcZZTkcJ/Rv9YV1iAsepyM4/K2Osi6KbcPOJBDaNpxKkdqGRdXMe0Qc+YdEhimwcilv4ZltcuToqATGnAI4s+KwCzTXFxVd+acnEmJfO3aGQsOD+L33m6EEjnG3JKKsiL/Z6xnJiWmuG6fbbxITHyKDr5mWnY7hismp4GvyhG2Dh4XqMrI1yX88+TiMVdRFZTDym3eQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea65398-138e-4af6-3a86-08deafc7dbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 01:43:25.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LGpjpwiugmIB+WrAx58zdjf5DV6HEhoRN3oIINTI0BQuWV87I+HL+kiBEAS8yhAe83xqjHpRBveGTuJZ4Gf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3900
X-OriginatorOrg: amazon.com
X-Rspamd-Queue-Id: D051E51876F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,amd.com,amazon.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20444-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Ratheesh Kannoth <rkannoth@marvell.com>
> Sent: Sunday, May 10, 2026 8:39 PM
>=20
> union devlink_param_value grows substantially once U64 array parameters
> are added to devlink (from 32 bytes to over 264 bytes).
> devlink_nl_param_value_fill_one() and devlink_nl_param_value_put() copy
> the union by value in several places. Passing two instances as value
> arguments alone consumes over 528 bytes of stack; combined with deeper
> call chains the parameter stack can approach 800 bytes and trip
> CONFIG_FRAME_WARN more easily.
>=20
> Switch internal helpers and exported driver APIs to pass pointers to unio=
n
> devlink_param_value rather than passing the union by value.
>=20
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_devlink.c
> b/drivers/net/ethernet/amazon/ena/ena_devlink.c
> index 4772185e669d..5ea9fef149aa 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_devlink.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_devlink.c
> @@ -8,12 +8,12 @@
>  #include "ena_phc.h"
>=20
>  static int ena_devlink_enable_phc_validate(struct devlink *devlink, u32 =
id,
> -                                          union devlink_param_value val,
> +                                          union devlink_param_value
> + *val,
>                                            struct netlink_ext_ack *extack=
)  {
>         struct ena_adapter *adapter =3D ENA_DEVLINK_PRIV(devlink);
>=20
> -       if (!val.vbool)
> +       if (!val->vbool)
>                 return 0;
>=20
>         if (!ena_com_phc_supported(adapter->ena_dev)) { @@ -57,7 +57,7 @@
> void ena_devlink_disable_phc_param(struct devlink *devlink)
>         value.vbool =3D false;
>         devl_param_driverinit_value_set(devlink,
>                                         DEVLINK_PARAM_GENERIC_ID_ENABLE_P=
HC,
> -                                       value);
> +                                       &value);
>         devl_unlock(devlink);
>  }
>=20
> @@ -151,7 +151,7 @@ static int ena_devlink_configure_params(struct
> devlink *devlink)
>         value.vbool =3D ena_phc_is_enabled(adapter);
>         devl_param_driverinit_value_set(devlink,
>                                         DEVLINK_PARAM_GENERIC_ID_ENABLE_P=
HC,
> -                                       value);
> +                                       &value);
>         devl_unlock(devlink);
>=20
>         return 0;

Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com> #for ena

Thank you for the patch!

