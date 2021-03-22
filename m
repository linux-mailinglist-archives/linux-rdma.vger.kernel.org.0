Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6947634490B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 16:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhCVPR3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 11:17:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:20094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhCVPRL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 11:17:11 -0400
IronPort-SDR: ctUfiaaMwg9WwAikwnMEisf+H1nFLnT+MSxcCoyq9zRuMQN1rd73QLQAA+BeDQKFLbHQczTJVK
 BOFvPWvjjOJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="170251786"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="170251786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:17:11 -0700
IronPort-SDR: cNzZszRPkLkYmJIFkEKAw07DPlywQJqjcR7UyxA/6fREwTs0ruFECAw8vzSbeQft2Vef58S8BX
 EzKnSQnepykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="592656287"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2021 08:17:11 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 08:17:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 22 Mar 2021 08:17:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 22 Mar 2021 08:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWJ6YwF+gf9W0kS1AokVvc0ZqS5P8jTEDODKindMSsjKrZrxMVDngm+0GXfCFSBmT7O2d6aVPtjFtT9PF8Df36b0JkzMM2hXeUuII4AfHYfV6jkwxIMePVwNihi2ayXPuO+nJ0d9M64laZh/euuVWAQuz0giS4ra+WmW4eplQ1Dh+TFKwsHuXM+7ogUBEozH3cpf9v6PUaT5ny9DcsdTAFqBnNHG6lUvEtDrTt9mm6z3M9UZUQte85lzmtSKEv5KAeq/jL78dqDK9mvmLr6jdHHljkULMmfCcmZdkvARk80ufdJobHgyYa+Wc80RyAaWLFRfnpWpMsAtuqg6BpAS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b91TGKlW9Yah2yxlP7AhK/B9HUHsRm1Z6Fp6RDH/Jvk=;
 b=H2ORCqR1MMTk/lNtTitlEixJlbBbLpS8LRMcvDQwV1j5lLE4MNIXB3yr9BuA0s9Ym405z0ChxqKYf69+S7hiXG3f+2Si01O/oshdcw1IkgQoo0BYXBUJ5s4SZJLUfq/VEp8xD+LGrh8IddviF1AwJVDD+2F6vRBgsTsqK5Df+oEuVy1455QYB32KP6xe5roEBnJE2SAZcalaQ8QKa3mZBA9laSqxjyr4ieaHB2g5FlFvturMhJyhdQS4AZdObn/S41z0eM4JeP4WCL5JSR/E2t1EsrqljDSpIofy902VLcOrZ+B65tOqiClRFQNMOLN9S9PtbafMJNvU1VJs8CtxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b91TGKlW9Yah2yxlP7AhK/B9HUHsRm1Z6Fp6RDH/Jvk=;
 b=y5EsijenfutlqZbLgJRpNPe5F4STDPAc9MZA63N+XWNtjwwsGmTu8+T7zpNACy4HeDwlTIodI3z/EyolaWynQTAkrH+bMKV+WvTNohCF4VKX69ayG+jbpIMSLLZS/CbD8rnyAUm2HRfpJffowNQt/ujgcIsY5TJSLXn1Wi/krqg=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by BL0PR11MB2897.namprd11.prod.outlook.com (2603:10b6:208:75::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 15:17:05 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 15:17:05 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgIAAB86AgAAC+OCAAAThAIAAAWWAgAAIBgCAAA2d0IABNB8AgAEQ+ACAAH0jgIAABbUAgAAKGgCAAA1NAIABWtHg
Date:   Mon, 22 Mar 2021 15:17:05 +0000
Message-ID: <BL0PR11MB3299321214491E0C3F9AD515F6659@BL0PR11MB3299.namprd11.prod.outlook.com>
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
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [100.34.146.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d208bda-caff-485e-569a-08d8ed458db4
x-ms-traffictypediagnostic: BL0PR11MB2897:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB28979622E676825F8D5476C9F6659@BL0PR11MB2897.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxcxHlm3VV4i5A9g/PM/mRaJGud4SY/BMCxDy3SrEGn4GK0o7IZ3wI1cJj6gJu151zA2MKvVs8kAfoEjvSjrN7akE7uzBJhLVynnd7TESESrbf7lJgilyq3w8GRRAjrRDPWcLyxZBlHBDaA1NMp4tRcpvp/LRXFerO7yDNZOsRiD8BwlDJSaGrFgZhD1DZkKPymReASWjbO3ohbU4YedrlzIrtkh1RrFYNtOh0avv4D8xJMofWwpwyFf3pdNF2LqYQ5xfTUXV44+IwBwdlz9Mut5FHjWylEeGRKu2rBaW/eoM4EKB7cQsgyvQB7MNX4YVoOIls7XK8vztudMVQthz3cJJF44bU2tOoeyRAK2BY1eiEB27JgShRQmSLc8GXqJ7+cdXDz2K68p8TfDx/61up0DW5u18ELo7q57Cakh8SMG78m7zJAt2dhaK543Dq7rdGsZ1S1HIPfE0Ae6eFehQt/Yh3hDqaDkdsUohDNqqm/MvVy4pCqHNceEcxYOZoyeWlBgX7aam/qFr264s6IJWE+lqQ0U2HBtPeQRT3v3CVxJuEAfme6+GM1OpHc0J0H9TpoRAQBLbIm07q2gyulVMiCIDcRkU82hkWY6jso95Mzsf0Ib0RUIZ8J6THd348/FFdV5H38Zu9YP6FeFtj6UirfJnCIILokUUud2SGL7dHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(316002)(52536014)(26005)(107886003)(186003)(4326008)(66446008)(66556008)(5660300002)(66946007)(66476007)(64756008)(8936002)(86362001)(8676002)(2906002)(55016002)(33656002)(38100700001)(71200400001)(9686003)(54906003)(110136005)(76116006)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q3KtEkxr7bqdS56YOBKw1XxYYxRrq4Fz02IisK1drCwPNCWtBESl0+4p+Xn1?=
 =?us-ascii?Q?LGjcKUps3R46MQ5AImRvk36U3Q81D3WMRtZdQ3IPVSPOV+YGW6bzW/w1n1yj?=
 =?us-ascii?Q?Qf7ItDeGTTDOA3tqDf7BB/HO6vNHL38bxPA3vuedRFC4xBCxKoo51pbCWFLr?=
 =?us-ascii?Q?vda/KyqL6BUp14XpwhH16hSUMIgiXU0bV73z2PsOS3aKEqm/5rE48qwXejov?=
 =?us-ascii?Q?gcgAQoXaNhkXqLVLXJyCDAcLVDrnjYIlrarlgxKw3nWTnsdJXL+zK3ZAjRBp?=
 =?us-ascii?Q?s7JTV87nJa6fu02EaiS0SPmN/eNfdMXP5CNJ2YmxXPjb0w0ep7t1RYVW451I?=
 =?us-ascii?Q?MGdZwvnqOcYimeh0E1fs41GQrWvrPx2RuNRsf61ImO5lwIZKAcS1mpjuphj7?=
 =?us-ascii?Q?aCTEma8uRsviDeK83jxU7kMSJ+Jo6gxV1jzOeiGfbsv68SiqqZqXmWHyA6Fo?=
 =?us-ascii?Q?6QrDMa38deWd7+zaAIbfU/UYn0S6kuyaCueNIDcekySzvzfjPxUQTNebaJDU?=
 =?us-ascii?Q?MazEmk+h/ZgCx9r1Szm1QBKy/5EOdP/57WH06IODQUq0P4d/Qy6Qv8mWT27i?=
 =?us-ascii?Q?BHWjpwHfO55UqXAAdVmHlf92o5V3PB3pwMg4D6N3OpbQC7BFP7QIqnTORypY?=
 =?us-ascii?Q?C5JXX/4hUXffqUq8gX2f9QXobHVCR3oM+kyD/sxCXO1F8TpbakNJKqF6gOEH?=
 =?us-ascii?Q?4oooCvmI2W7evoqAqTNDYw5bDdtteWigcTnY+M47o+Qa6spIwzcszVsBjgC4?=
 =?us-ascii?Q?QvSHAk+zZJOrYw0ZZFEkhNjgYZX41dbt3wTtZMHBi+Nzqy5nhO01CP6dEkyV?=
 =?us-ascii?Q?e0RreWVrXcpZIKE3/jODvER44VuNWIoPAG14KT2N0ecHcwIh1ZF+om0KLxzn?=
 =?us-ascii?Q?wpWjspzhEah6CYcS1tQHTNn2gMPovF13XhWwV0pdRf51uE+RZTLkDWRHwJ8S?=
 =?us-ascii?Q?PVDMuIfYHFEsEJCiKjr00IeK5XWXZ9iHxLqtk+0yXxitimAiv0VK0sHhBEmW?=
 =?us-ascii?Q?Awx8zo4Pii1OAf1LIJG9zOcSfe0KxmxwNu6jMIlq7cOFuRL3ddczfvIKbQCZ?=
 =?us-ascii?Q?DCjV5hh4w8loNzwt/ttiX/4iZceohUgEmcndrSEMF1L0t/6B7GleBCf0HBAr?=
 =?us-ascii?Q?ctCU4MNC3Uj9A2V4CSN11naotNPDtT+0XpKf6DlHgC83/BNBDaz30HR5D4uA?=
 =?us-ascii?Q?2znjwZzn3ST+wT6o+kJTcgYto93GKlgUZNn/MVlpTiuhoMr/CeUCKzXdX2H8?=
 =?us-ascii?Q?yLt9CRCOkO8holkE+80xmAHj2kMd0nt0eA64CfWlZfsccFbSh2k/gX1X4vxd?=
 =?us-ascii?Q?nzKE0nPpd7wJBkL+2wZnvpcA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d208bda-caff-485e-569a-08d8ed458db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 15:17:05.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcRDU/7/J+K228mvPpsIcB9M3dRBMQSJrbAw5g7arXWvTFVw/dYFwKA9v/NlU3wDHfINvuPqgWZf8n5Qfvg24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2897
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Over a long time it has been proven that this methodology is a good way t=
o effect business change to align with the community consensus development =
model - eventually the costs of being out of tree have bad ROI and companie=
s align.

Agree.  The key question is when will nVidia upstream it's drivers so compa=
nies don't have to endure the resulting "bad ROI" of being forced to have u=
nique out of tree solutions.

> > Putting a bunch of misaligned structures and random reserved fields
> > *is* garbage by the upstream standard and if I send that to Linus=20
> > I'll get yelled at.
Let's not overexaggerate this.  The fields we're organized in a logical man=
ner for end user consumption and understanding.  A couple resv fields were =
used for alignment.  I alluded to the fact we may have some ideas on how th=
ose fields or gaps could be used for GPU support in the future and this mig=
ht help deal with the lack of upstream nVidia code and reduce the ROI chall=
enges for other vendors which that causes.  The discussion seemed centered =
around the attach parameters, attach is executed once per process at job st=
art.

Todd

