Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1512344D51
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCVRbb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 13:31:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:61309 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhCVRbL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 13:31:11 -0400
IronPort-SDR: Chck42mabpgkwN1pfFpqD3AR854rhX13zC/T0ow5dtgBo0wBASixAFWKkwlCPy6GIMMKHKxU9R
 AE+X2NDBv1Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177889426"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177889426"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 10:31:10 -0700
IronPort-SDR: GmWh4R6T4dv+I+Q7iY5atqypgDmi/O6KaGiyZs18rcQwDwXnGeaRPlEgRFr7SCyRcJZApzFSLq
 9mahBW361H0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="413109844"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2021 10:31:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 10:31:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Mar 2021 10:31:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Mar 2021 10:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT1pIDD1yRikaBARdUmrNnId5TOIvgulGS/aYW0JGOdZUI0szuhObtXHiGTIzvFRSYfo9ziwlP2hXUBTfmG4CU3pGs5JqQevVHYhihvwAr9O/ypuWUoIu1ncnIWiYnsinTwciGZa+9m+HkSfUFz+eZAoknHBrHoQtZYuB4hJS7dyCyBxeUBkxm0ht8SRoMGv47wdy2e/UpzZLHrWrVZcYoXyc19E/lafM1l4J0sdbNsTYjZI+8qNz1RgDRmmc1ShNn/MnIzycWbiMXgHNDYMGWWJpPMqmc7tvnsYGjnZM9oaLpR0JnHMVq8bNSoi5HnDatlPuOKi6A+qXxGB3bWibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JYeUq+7CjgeB509iczO/MrbNb0Zvcs9FjQhJBOl574=;
 b=UzA5BZgr8tubUPinDRl9A5dxcTormyMppQrQ2w3jx/L6Qbxy9wZgpo+kAUSw9k2g1te+ZhJNAmTzu4NLTuLkr6R/yQnk1hplvt/xyhbcOzPyqsZlpEjKNn3WDw6rkDqLLHghkKJz3RSJZHMdAn3zScxESjJznv03aVRUu0F9y/yB0FCuxlfJSnQ55fatsd4IKQQriQnhlf4boksdGZaqFOEo7tjiNBwNnWMhVBwhMMB2nWgnXr3lcKAQbaybz94+dodEN5D4N9z5pus8lHkIMOIpDzEYV/YS6PSnABsELM8NS2U/stc09QLGxhdNX3ECPJBAst4UCbdSoI3vHob+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JYeUq+7CjgeB509iczO/MrbNb0Zvcs9FjQhJBOl574=;
 b=e9cv/2+IH8oR/8sY+SEc62L2SnKvYBY0emoZlob8/cAH4gjLNwSLrpzMZy2pCF/We12cCoN6INaKSGibxnetm1e4elCrmZRbqRUkDsPyvE/G4wXEyofTl+xUjPWy0F/0b/SA1XjbJp50zTpoyo9PRByBNRPvbiEimQSHBDIqM9w=
Received: from DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15)
 by DM5PR1101MB2171.namprd11.prod.outlook.com (2603:10b6:4:4d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 17:31:07 +0000
Received: from DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::6005:3163:12e8:d988]) by DM6PR11MB4609.namprd11.prod.outlook.com
 ([fe80::6005:3163:12e8:d988%8]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 17:31:07 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9qv1xzuyElT0mxzSqxlVtvR6qLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAexAIAAA/SAgAAFuQCAAAIgAIAAAWSAgAAIBgCAABjlAIABKNcAgAEQ+QCAAH0jgIAABbQAgAAKGwCAAA1NAIABc7XQ
Date:   Mon, 22 Mar 2021 17:31:07 +0000
Message-ID: <DM6PR11MB4609382524AE6EA1EAFB15B29E659@DM6PR11MB4609.namprd11.prod.outlook.com>
References: <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
 <20210321180850.GT2356281@nvidia.com>
In-Reply-To: <20210321180850.GT2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.67.182.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7f34d02-951e-4174-eb3e-08d8ed5846de
x-ms-traffictypediagnostic: DM5PR1101MB2171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB217110D8ACA77454D905A54F9E659@DM5PR1101MB2171.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhPLmxAZWIQShaM5zBM0alPsIQPBOxUss+7XqiX40aut/+edcTQBtF2hi3L81krlBduMOZh8+2Y8vFvwDPHg++SVIKm6xLLt/dCWN9myAgWLhmqK+FwcTgnyX4wLmPgS1L5M+6tM04NqbZYcoyf+GFdoh8PLbcNAqzL/uTtpOBCdKYJO8NZzNNSNHQ5Ap0BnIFpkjpyfqbjgwrQkGUgn6mW4PxtmOsFJ3agrMUpiOux3Jen0hqIBGCAheqf6D9OPS1QPhLLTVT/HhlcqK2W5kPlSFMK5Xp5LarmKTUfiaPcsWzUTpxbDmdV4xEQyjAz5Ycvtgb9uSezBMUWMJd0AefmFZAhSPCeqQiEkoUW6M4wDmh0NmmEWfGIH3Cu67SMNkkmZ1mGSG6FuCBSwQ6qRaCThE7qhoEXRsU7fX5wX6SnwsGzz3sSHD+a89KR5+jYixAVLebjXdWySPoDt6A1aGzn5Dhrb4P0U2kKflLQCIXrcJQXZQ1YARXpRK42cndWYJvP1aRHwRPoUHvdNxbAqpcB31MlxeNxxGpIzbZ48Jaky9J0CpFUEkaW2sGrgswVZK6ZmveBZJH4Hmj+xo4ZIGgLU3/9bbs6l5ni9JvK47tfA4fPDAjDLCs4GBqZMz/OkmB7ViUw4mRUOku9cgHwZVzvkRjxpkdPLucG+Vv5G3K4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(8676002)(2906002)(26005)(9686003)(7696005)(55016002)(186003)(4326008)(52536014)(66556008)(8936002)(86362001)(54906003)(76116006)(66446008)(64756008)(66946007)(478600001)(316002)(66476007)(110136005)(38100700001)(6506007)(33656002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?wWX/BHbbxL8KCNAtqkMjVbKXXYO2wdX4VrTBRxwnatHBrtHFe9f8bZi2?=
 =?Windows-1252?Q?QG8Ll34x1aXZ52DtjISQCUW8+96nNCoqNW6sCLvIqYpPRIuLbCRo95yo?=
 =?Windows-1252?Q?2gUdua/pY6V3cm1e/hsKvozjcswSK/QMddXs6tirc9Is0JrZw3/oIybs?=
 =?Windows-1252?Q?p1ysJGeZCcxZF8W4r3FS0eVndMhvz78PjYfyaA7FEmSYCsR3P8TBsB2/?=
 =?Windows-1252?Q?+EfInOJb7/Hctg3x36DfHnnC9MlY+5UIS6O5BV0qkKBVC0ulIi5IERS5?=
 =?Windows-1252?Q?14XtErSndemMG9T5kR00MIZoy8NB+QraBch1hnO9afIsgrIDX52Yn+Ql?=
 =?Windows-1252?Q?eduglYEFTaqCDHtVvHTIafkJNrF1ciJZvtaw8YkKtKOSOsxlw67ZWhun?=
 =?Windows-1252?Q?6YcJGtzdnl1eHlYus/spqNUlFfU/ntp0+E2YY9Tgsmf0GRJ2TZ1FUnhY?=
 =?Windows-1252?Q?ImuaAJrEt7eCYLVWbyWaIaVpVRmmXIpT5OrKzCB16rpUuKGebUmDW0/A?=
 =?Windows-1252?Q?apzlC6hDtRfITzB5Km7XmhJbP5bZoLATIVjND00aOAjLXpkIWlbnBRXQ?=
 =?Windows-1252?Q?cnitmRkZTqF9dx1SfTU7dq92GQurxnVxNA9ft8/noTQJmo4SDMjP3Db/?=
 =?Windows-1252?Q?WqC+hwBOgzLAQYOs+FtXYJDMCH9fEFXrxFxfP7f7pLfNo/oEuwAdO4EE?=
 =?Windows-1252?Q?x46cPTsjzZcWe8aPDu3DCiNDnppYiZUrfbuU82FGpeLtZXRT5/Bp7JPX?=
 =?Windows-1252?Q?VUf2J4X8+XK5tGVDjveEow3Rn9a45YmOcsCCXQLzM/L+cdPjlaNe0sgA?=
 =?Windows-1252?Q?5JF4KhX/ZZ6aGqP2ZpuiIX0Tdh3vwSK1y5VOrFqeDevLgJVYvgvt8is3?=
 =?Windows-1252?Q?8jvD7h0P5/2uBY3E9vrVzsBwcrxsJSj7UKRA2rV2SGWomPSeDIucuOt7?=
 =?Windows-1252?Q?sTR4nECzmLCh19Q/4k9QrZsIjggcxY0svnDlu7qG6pIgPjEQ7FSNHw1R?=
 =?Windows-1252?Q?l9gY57oMR+/6PrSPN2ACOrbHtLo2I3R7aQwvC5sirwfhi3GAlngOk3pI?=
 =?Windows-1252?Q?/xNZNQ78s6OTMWiCmwgWqQOWUXkB7NM/+CMBycK/LgcTpunVCojtqX8Z?=
 =?Windows-1252?Q?5nTyz6qL0cydoLMpVSQoK5hGWJC/96t15F7EmlOSF/+Sb514SCJH+KAi?=
 =?Windows-1252?Q?7/Ut5vykjeo8TEgRGfQhh6OjALrcAcqkFmvh3Zc/594Ut/t6RBSVsbU2?=
 =?Windows-1252?Q?aIrKdDkpkNNh+nairbAS8abXkGwKzpIsvsRC9b5ZVHqIurVZRjVuocwT?=
 =?Windows-1252?Q?0mXIvV5oP8F0Eu7VvHdqxAgOIPDzQUQt3RpDjqfC7WGIChrlfN1IP73o?=
 =?Windows-1252?Q?XA78b9ZcZTGy4VCHGfj2GJn6hoAoCel/NmKLrDmk98ehD2A5vexgfM2h?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f34d02-951e-4174-eb3e-08d8ed5846de
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 17:31:07.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux2jXckWdoaQSEEq77wrkdlvSZ8ull2RQcbywbmbVbWcGrK4hpa3mGzD9cTIWPM90cisq5Ch3uDDuEMLpkAWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2171
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > To be fair it is sent as RFC. So to me that says they know it's a ways =
off
> > from being ready to be included and are starting the process early.
>=20
> I'm not sure why it is RFC. It sounds like it is much more than this
> if someone has already made a version with links to the NVIDIA GPU
> driver and has reached a point where they care about ABI stablility?

I can take some blame here.  A couple of us were asked to look at this modu=
le.  Because the functionality is intended to be device agnostic, we assume=
d there would be more scrutiny, and we weren't sure how acceptable some asp=
ects would be (e.g. mr cache, ib cm data format).  Rather than debate this =
internally for months, rework the code, and still miss, we asked Kaike to p=
ost an RFC to get community feedback.  For *upstreaming* purposes it was in=
tended as an RFC to gather feedback on the overall approach.  That should h=
ave been made clearer.

The direct feedback that Kaike is examining is the difference between this =
approach and RDS.

- Sean
