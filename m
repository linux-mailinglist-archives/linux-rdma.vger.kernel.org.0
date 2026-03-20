Return-Path: <linux-rdma+bounces-18435-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BSNOBD/vGn15AIAu9opvQ
	(envelope-from <linux-rdma+bounces-18435-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 09:02:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED032D6EFA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 09:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84FD304ADB3
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7436E496;
	Fri, 20 Mar 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0TrdVal"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5C36D51D;
	Fri, 20 Mar 2026 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993724; cv=fail; b=GLKPzeL/0cKD4zT1A8HCpiiBBG2X1X9fPEzhnMhoYf2/8+Eu2VW0x02rAk2HI2J7Tk9KRprwuil2UVY04sjdJqStFV6J5jmdbpjrQGOBHcGs93hxdencUueW0bUZrx+xg8v7cI+RYeoCR7c1rKEBnm0ozUnbwiMDtBR3K8KEMbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993724; c=relaxed/simple;
	bh=yJrrvdtujMjixLfxuC0/z5sbFsdNwXZERUEljjeS908=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6+IR5Mlxx5mDefxrUWgGScgYJJ9jPrkomUhneDWQzbUY370wINGw8HNnpEkOBFngfagoUdv3Pdv1Y1Tf36NpxrHMG5IOJs5wSp6oFFvdPeACcahzPfX/yjx8s3d1sTJb8oE0GBpwnMwNpvwC5cKIZ6mFHVzjiKzLzSKaFkB48I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0TrdVal; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773993723; x=1805529723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJrrvdtujMjixLfxuC0/z5sbFsdNwXZERUEljjeS908=;
  b=R0TrdValY3s+XbgOQDoStIh8CH5GA/GtFUSwTmoGG/K6rH0h/H02D6lB
   HbRSlyWEdilSsQbBTdEXyEOWccfOm3lXeK5h0yM2aoHSzMssAwOxez52b
   dIVArdRVXHD1f1OzUnc9CGWdGXCdRkX2G0IoWm3QW9KfsM6pz438sXHmg
   scIDV2PatdkpAxfZuWr1JwZHF5mcvBTcX4iN8CU0h2VVLltM1m9rhn3bh
   IonH+UUrCf45w+BUDtDMYyENONJ3czFwxEJH00+XWSEPXS7e0oWQ+DoH2
   0N2oeEWIhSxWIAUbDlQZGWQ599Ys92HGhncwkS5kTtEktfW331Yh1dvJc
   w==;
X-CSE-ConnectionGUID: KG0spiKURNCJchb6jPIP0A==
X-CSE-MsgGUID: oTaQeRMWQ8+bwhxsC30i7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86153517"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86153517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:02:03 -0700
X-CSE-ConnectionGUID: yHaSzU71QMiybFml5tRgUQ==
X-CSE-MsgGUID: l/mIxXFjTCOLDplzC2u9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227691148"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:02:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:01:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 01:01:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 01:01:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5X2+0cVHXSasrdc6UxfMDtwAyewmgtLvRL8WbmjJFiprnoh3kWiLbxqL+IW+eBkCnDHQSr3kGokV9A4apMkcXSWZ35vvSEPx8bTkqpKUPRlfZns9h6NQXG9BC+6rN6hgjKZRzMOQEoDBd/tTva90FIKoWdxd8Si4ndjzcTsRx0TWGTzMgKtuHH2O82QFAwHfNhyfD3wiriv96QGiMnj0+T04UtQTTD05U8z4PtGggw8ECRejHvVTdiyfEbHaMtCtuzxEHbZVJqt5zO9zLDW8xVghHsra/+1xGrP4NFeaTRVo2yvBghccP7Ymwr+pH+DGbE5Uj0ERGJ54CxXo5KyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2gnX6RWebOrSa0SZ/zsQbtg1142EymNvBnc99ndoc0=;
 b=dKQGU3937UxVjsXshN3Z5zDcLZyNiEzDXjee4D/EwNzgr43VlwdwqMJk8NlkeUSvy79EqRCG1ny6JNWcWebucas3rMhgXwDpGuvR8/aGY9cxK+m0Jhq8/05u3JGbARFRrJlmuBWpqx2UdV6dPRRtJNHXXMx5hUiPkjUEN+yw/V5wFjSLUTycFxLNKZQLp0GhHjDnSFmTcXIv1SSjJh6C+vJuiiLbA55w33pB9ydx7YCUK8CWEQzu6zjySegdRg9Qikhs2vSixmdjH/OaSeB4zI5A0NkqiBP00lzkn4iK2HpTwzr+RXWhSLYO2tSqfsGeiY9P6lk8jJh7KGQzYtQ+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 08:01:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 08:01:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "pavan.chebbi@broadcom.com"
	<pavan.chebbi@broadcom.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "mbloch@nvidia.com"
	<mbloch@nvidia.com>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>, "dtatulea@nvidia.com"
	<dtatulea@nvidia.com>, "mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "willemb@google.com"
	<willemb@google.com>, "skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>, "kees@kernel.org"
	<kees@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH net-next v3 04/13] net: move promiscuity handling into
 dev_rx_mode_work
Thread-Topic: [PATCH net-next v3 04/13] net: move promiscuity handling into
 dev_rx_mode_work
Thread-Index: AQHcuAhxDQko5K947EeqgLgFt+jJALW3Dr9Q
Date: Fri, 20 Mar 2026 08:01:55 +0000
Message-ID: <IA3PR11MB89866C27B28AE7D7D807F37EE54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-5-sdf@fomichev.me>
In-Reply-To: <20260320012501.2033548-5-sdf@fomichev.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB8807:EE_
x-ms-office365-filtering-correlation-id: eaec0c20-3b60-4798-1834-08de8656f448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|38070700021|7053199007;
x-microsoft-antispam-message-info: pBSQftYDbJiuGPANwjh+srtUrqs0HHatho98JPK80gk+LFfcy+mcGdU5WGXr3WweLKBTX8TcZ4sN0VANRssUPJGTEyyZJ1Peu6Rr2E44PquVQOKzc8ZgqA4COBZ+W/Vo6ieT1SWlifCu88D7w/fEk1bO3zEk2E34kZlXm/tDQHzn4U1NFnUidGhLf8HU+IgLEhkmYrZlhOyukugQvl/6KuCzjPUgu6/vu0hpTGb5gtB9uiW4ma7AQEieAmz4QeuTqrDDjlIZvHowHikxIU+r/SmktZCQQiGp4MLP4gREpQCueaEd31PZ75wgcuwZuf3GWtdopR0pdqK01++J0bAnWCNJlQ2O+mobbnH6MYaKtNB0IxaAIwQa7JwSp0tnrJ9ofUDjIXy/PBaiwblFAr6mchynmP1UFj8n030Q50aLjJJHXjaWL03Cb5WRkJlLhR2G5j7Iif25IDjpzHazBc4qg/IDFh9K656vCjxdJD8JXs/8iv58B4tnlSXgSTNsyJENCsB1Rh4dGvIqyUpc7HzTXUazlVAxhuXBHwB2PLCgJX9EFxSpZv32dKFlWZwTDkQyt5sHxslerWCRCwHeOTjxaolTolO3IOKbsp4hkZZqHBKtcQdIcH6mbF18QECDQD9262QKQAynV6NYmBCudcNmyJWjvis1LDsLh38OAlm+rZuaYS+trEzxcwH2jJ02FXvJAUmBrhSkHRrBLcOed325y81PuNb2Uzh3sFWLxJHdeTBDXbVhIjx+CoVbzo7rMpO20k856ja82jjJv00EL0uWDYtTA9RHixIKfGBH8kQvRVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFRvvyhXLo69/UTmpOC6WpjCliHLxKVnk/xck7VZJ10a7Mbav35EkgZWCoF0?=
 =?us-ascii?Q?H+RP41IWnq1GCqAzU1tlUPe1/Hc0x9UznDZgPOyEFLqJ0/5Puh1It7lJh5Bv?=
 =?us-ascii?Q?6j0bpHHYimM5K7J2+IT4JTrqdsdYrxVEr/8PRrUR6INYuLAi85kZcvIJ0T3U?=
 =?us-ascii?Q?q8brV+7TsRP0BEBGL1abi0MPYnDKvs6QwuBDxKQZyS4dYTfjah718OwWrs31?=
 =?us-ascii?Q?sVGwN4dvaXPVhg1AWcpD7Aec6tB/6KSErEKa0/rvHpq+WCFYLQGFMIphSEWs?=
 =?us-ascii?Q?PJSr7bw66Edo5P1NF3xovXK0DflhWZQOPJfL11BuxnJE6ZELXe95/BOCJ/vY?=
 =?us-ascii?Q?1ujPZQyKhXkEEpIYKLvSeYGO+XblGhceW5kl/n0fiuM/2tT0569YLt6qPUpt?=
 =?us-ascii?Q?KOemF9mN7eaNJ2UVYe5ji8irdAqldkQPWa0zgZG/ny2YbAZ1l8to7E88NzYR?=
 =?us-ascii?Q?Dr1vcDizGjX/qlYbB7ATa4xQIRDSCH6iCTwo/rjJ40m1MfHcJOUAhM5mvvOa?=
 =?us-ascii?Q?+prxEUa59a0m7dOMWJ+vbzcbNEHnFK5Ub81/xz0/Vzcyvvx6gafDlAx01UNu?=
 =?us-ascii?Q?HdkwxevQSdy+ypE8qCGmDZe6p8swNaOG2jIPlJEdKGWkUAinrT6E061HYqcG?=
 =?us-ascii?Q?ViEJSAKQokql6KwmZsL7Q5z6zveqbB0eSuqgxLr0OHqddPaxarF/fKixPXC7?=
 =?us-ascii?Q?N+l+VXOW4J91RRX29l4ql842N/h1TXQ2TTiVpGj3Z1BLXFDLMHkMPm76c/2n?=
 =?us-ascii?Q?MM4GVYjTV1YrmXT7cplDbyhjmSTwRn+X3gb6CXelAHLOtLn7CXW7WnETuZXz?=
 =?us-ascii?Q?qIoDF3BVuO7LURB4HFLwrfvuALkS76qbp55S9CkV0Hqsyp0iCCv8+IT29+7h?=
 =?us-ascii?Q?uO/al1eFSssIbNxzyHK+kO5YdWEn6vhpRQU/Z41Piu8NYaRyfKHaj+m9rslj?=
 =?us-ascii?Q?Uc3XYDPeFY2zMBqehKAarjvbRJ9zIZhFzeNgfQdOOGqdIBnhRrbWh6VotrSC?=
 =?us-ascii?Q?s/Wo2/rSRhKYutBsiSKBJ0BpT7BY0ZgbtPyLZMouYOSEZFHI7z3w9H/W/PNK?=
 =?us-ascii?Q?+esH3LJlXlaf2tgpXYMbO9NHmnOWl0JGmNDeJQqH5HrGO3cFEnm/H4EzxBow?=
 =?us-ascii?Q?ngt7HB5uXwFxXn7e/PogAoYnukM6ZtMxN5Uo7k3E314DuqI8B9aUyOJGccC7?=
 =?us-ascii?Q?rmXW49QW7Kq5xypKFCFAuO3qeFLk6NAzzbD6CpSeYW+gAloQtWpjdWuZfbN1?=
 =?us-ascii?Q?SKSwkzp/2+EIIR1GupfQ2N/YvJQ4HybSSW1oZGt39E3/nUBjM6dlvyc/gEnT?=
 =?us-ascii?Q?ov+BiA6ydaMDzhnQyxqUMNq/bKXXsA9fiPv7c6zcZxtO0BkW6bulgtZWyQ/8?=
 =?us-ascii?Q?ZKfWDV/WdkoQxuyw+TMVVL+uUK7wQ9sqo5lLTg2goCwKyK06DUmHwfHFp3j9?=
 =?us-ascii?Q?DMdEGc885ECtBYvjVTFKr19H6PJfCZ11nJxb+vaU0/kGis/qrCYyyijjrsHM?=
 =?us-ascii?Q?C+APn88WeHauUuNCCwmCtHD3lrvXZgjXWVH76I2F5yW5ySHDLaAnUior0Hfv?=
 =?us-ascii?Q?xjwebWF3NW+HPLClqrBEN7rFKoo9cweQsDux76MLr0fqEsfATwgcr1dJBB7z?=
 =?us-ascii?Q?Ac1rM3rUCMcEvDD7/eWCB18XLlq4kzrNDYi7IywwOE8C81yYerYH7I7yB2X1?=
 =?us-ascii?Q?D4W8olwKXjOP7jXOxKS81ni1NEtlqzwyHxYs9kJ3u+HiLRn3STgjOlT679fd?=
 =?us-ascii?Q?zXtvxIOa4qG3GEH5nN7sNPH84W3tg3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lurZaLnFZi+4cd63sAWoJkvDyxD9r4UZ/U/+W3n3ZkdduHJfbIAEh6+EcQmrmJF+3uIOaodXikCn6EP8KEHWaXvISq5s3k97j+/0WjJ98f0x1BagcHPnzVx2cRHGQTKyEsRjrg/itooY4vkP902bKWQzh7q7NXYTvYOqU7abuwLDxoDst1UcKpIYZBcnz5vXkyKaEPTYHsgZ+Mu1QYg8Vc2lj0Rk8O6uRlvfhhJwk2UPubXE/BJrh4u8JqWGNqzJDtrpxZtsUcmB5/z9rnB0A0NeJvjGaIHOkjmOPPmZYz/6M6pdRSeg8Xzw2jyAOlelAKYbryVHGQyo8zP1gYVhJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec0c20-3b60-4798-1834-08de8656f448
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 08:01:55.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rF7shT+rLAZGwxId28w0IyL/SaikvhFxrYssXm1XP6v3NrOCtEqUGOKJ4UuvmmDXkLDIbRRFLaC3V4gYbSN1t7VNR94WxQ5W0DmuXldF8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-18435-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.943];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8ED032D6EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Stanislav Fomichev <sdf@fomichev.me>
> Sent: Friday, March 20, 2026 2:25 AM
> To: netdev@vger.kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> skhawaja@google.com; bestswngs@gmail.com; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; kees@kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-rdma@vger.kernel.org; linux-
> wireless@vger.kernel.org; linux-kselftest@vger.kernel.org;
> leon@kernel.org
> Subject: [PATCH net-next v3 04/13] net: move promiscuity handling into
> dev_rx_mode_work
>=20
> Move unicast promiscuity tracking into dev_rx_mode_work so it runs
> under netdev_ops_lock instead of under the addr_lock spinlock. This is
> required because __dev_set_promiscuity calls dev_change_rx_flags and
> __dev_notify_flags, both of which may need to sleep.
>=20
> Change ASSERT_RTNL() to netdev_ops_assert_locked() in
> __dev_set_promiscuity, netif_set_allmulti and __dev_change_flags since
> these are now called from the work queue under the ops lock.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  Documentation/networking/netdevices.rst |  4 ++
>  net/core/dev.c                          | 79 +++++++++++++++++-------
> -
>  2 files changed, 57 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/networking/netdevices.rst
> b/Documentation/networking/netdevices.rst
> index dc83d78d3b27..5cdaa1a3dcc8 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -298,6 +298,10 @@ struct net_device synchronization rules
>  	Notes: Sleepable version of ndo_set_rx_mode. Receives snapshots
>  	of the unicast and multicast address lists.
>=20
> +ndo_change_rx_flags:
> +	Synchronization: rtnl_lock() semaphore. In addition, netdev
> instance
> +	lock if the driver implements queue management or shaper API.
> +
>  ndo_setup_tc:
>  	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT
> locks
>  	(i.e. no ``rtnl_lock`` and no device instance lock). The rest
> of diff --git a/net/core/dev.c b/net/core/dev.c index
> fedc423306fc..fc5c9b14faa0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9574,7 +9574,7 @@ static int __dev_set_promiscuity(struct
> net_device *dev, int inc, bool notify)
>  	kuid_t uid;
>  	kgid_t gid;
>=20
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);
Can you explain why do you add new hard precondition of ops lock must be he=
ld?


>=20
>  	promiscuity =3D dev->promiscuity + inc;
>  	if (promiscuity =3D=3D 0) {
> @@ -9610,16 +9610,8 @@ static int __dev_set_promiscuity(struct
> net_device *dev, int inc, bool notify)
>=20
>  		dev_change_rx_flags(dev, IFF_PROMISC);
>  	}

...

>  	__hw_addr_init(&uc_snap);
> @@ -9704,16 +9720,29 @@ static void dev_rx_mode_work(struct
> work_struct *work)
>  		if (!err)
>  			err =3D __hw_addr_list_snapshot(&mc_ref, &dev->mc,
>  						      dev->addr_len);
> -		netif_addr_unlock_bh(dev);
>=20
>  		if (err) {
>  			netdev_WARN(dev, "failed to sync uc/mc
> addresses\n");
>  			__hw_addr_flush(&uc_snap);
>  			__hw_addr_flush(&uc_ref);
>  			__hw_addr_flush(&mc_snap);
> +			netif_addr_unlock_bh(dev);
>  			goto out;
>  		}
>=20
> +		promisc_inc =3D dev_uc_promisc_update(dev);
> +
> +		netif_addr_unlock_bh(dev);
> +	} else {
> +		netif_addr_lock_bh(dev);
> +		promisc_inc =3D dev_uc_promisc_update(dev);
> +		netif_addr_unlock_bh(dev);
> +	}
> +
> +	if (promisc_inc)
> +		__dev_set_promiscuity(dev, promisc_inc, false);
But it's being called here without any netdev_lock_ops(dev) ?

> +
> +	if (ops->ndo_set_rx_mode_async) {
>  		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
>=20
>  		netif_addr_lock_bh(dev);
> @@ -9722,6 +9751,10 @@ static void dev_rx_mode_work(struct work_struct
> *work)
>  		__hw_addr_list_reconcile(&dev->mc, &mc_snap,
>  					 &mc_ref, dev->addr_len);
>  		netif_addr_unlock_bh(dev);
> +	} else if (ops->ndo_set_rx_mode) {
> +		netif_addr_lock_bh(dev);
> +		ops->ndo_set_rx_mode(dev);
> +		netif_addr_unlock_bh(dev);
>  	}

...

> --
> 2.53.0


