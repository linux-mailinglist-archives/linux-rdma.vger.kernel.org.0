Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36C34663F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCWR0I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 13:26:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:5542 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhCWRZq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 13:25:46 -0400
IronPort-SDR: 71fYJGBTh4p3Dj1/IfKOSZQomcE/Ct0M8uiGKj1lo/c3oei6p29p5bkqM4ZyxcnkPWbY9bt1MP
 mVhj1mSGQz4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188208873"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="188208873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 10:25:45 -0700
IronPort-SDR: wbraOnaFyXdz6nV6qWy+XQx1gZbvNCzgrqGHZBQCU7jeOaqSkpf58lvsdADncb2s4Slq7jHn4h
 nTURA3unA0PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="524913108"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 23 Mar 2021 10:25:45 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 10:25:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 10:25:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 10:25:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 10:25:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkt6umGEtjh/0kXi8hWLhatsZTWF3yo/Plb+RmciK7xA/CCQZFgdSFXDQGEC8GnKP8bojVJ9ky5djMHBpasFj+AQOJ36BE9DrSNnIgegUaq5seGz+i96CgBc0f4ZLjFQ+GQUJQkesgTA6AUoX/BkRi0ZD3d0NfOeBXbQyrwDVZIaDBfCkYPcN4t9mDOpXOxfcudKjqjQMy6P5tD7JUp73sr/BXlbqknvjYaE+z1bSKStRly381x2GONr0iRpty0pGEevxuSiz3E3qFWGTXZBb6+8PHKtJVgITQvVm+QmAQNB81H/rCtSkQ0OzrnguDyHHGyQU9JYzOypyOk3NgpoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc4X/kvMElqtPj3Y9QxYH5tU9penfnOsllnJ+bZ3SNM=;
 b=NwNDcTCNhr2iivWp5+FK640CiFs/jfZvuY3sEd1BCzNEClI3VxhcSJB3JcKdNkhRW7AKZNVFElMRpLcyukGnLpfCqoC8f2vNpZ+abOVm8vYeXc3ppi0RVAHahrC4TcbjpsDUhY9I6BacHNtVoY9zjqITdpjjQLM/ZV/UZL29r8e/zlSmI9sevKH5vJoSP5NWdZD0bWfUCquh2LxDGL16FjvFACsljwc3XDwKg0aYuzHZRGaV2nuhwM8dijpV7bY6w9Cdo8R0Q9E/uIM74tpaQCNEUaRMNzEJxiuYt/MRqHxNpA6brPdDaF7ZH+RqTNz2HIbckHdJ9gTwcd9vH2+bRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc4X/kvMElqtPj3Y9QxYH5tU9penfnOsllnJ+bZ3SNM=;
 b=f+wQQKuRoomppf9dgVt6DzRx1XHtF44g/HFEwi00wGxy5hjEn4c4YnrZn0VaF+LiAQ2o+32qDl/K9bUgIZ+AuDTZMHbkRFPgOcCypvwmWHf4tDchyrQ4Dumn+w73mRhAi/UPcVuANQIRyDPlldTlvTOVX1U2GOW5Hd93xgBaJL4=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by MN2PR11MB4448.namprd11.prod.outlook.com (2603:10b6:208:193::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:25:43 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3%6]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 17:25:43 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgIAAB86AgAAC+OCAAAThAIAAAWWAgAAIBgCAAA2d0IAF19CAgAAEZgCAAAXKgIAACG+Q
Date:   Tue, 23 Mar 2021 17:25:43 +0000
Message-ID: <BL0PR11MB3299B764F783B77F018CC759F6649@BL0PR11MB3299.namprd11.prod.outlook.com>
References: <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210323153041.GA2434215@infradead.org>
 <20210323154626.GH2356281@nvidia.com>
 <20210323160709.GA2444111@infradead.org>
In-Reply-To: <20210323160709.GA2444111@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [100.34.146.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e216c2e8-11dc-4d54-c33c-08d8ee20b00e
x-ms-traffictypediagnostic: MN2PR11MB4448:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4448F2BC09EBD16BB8423AAEF6649@MN2PR11MB4448.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WcCQbjJ2yezIgh03wgCuan1kSVG5CKH6y4Ts6XfNHelC7FSTq9eIaMIELouh4DWEhJuuPxUyHajUMUW4LO4ZGvKiSZy+xwyVg70EdZNcTOFIpNSS4oXZeoQjHEIiLM+hjTf6XigzAuQ8sMuZzWmfvtDelX2uvqCM0RKj2kWOncZpePuAWXTgOTh2GGb7onZUtcboEvR1MYYzKEF7jpFxsnmG4x0PAMbuamwSGJQ+EAp7nLxr4nIg6PWQp50IzssyyCvM/nXqQb/3TDQca5yCt306ZW2NJ4LhTAoS2F2EPpVaGAzkN7t3K0164D88YqiWDft6e0tV6J1u2EWRG3iQhxFyq32iSf0mq6STep+ncCPmqFqPj4Hh3Cc0HUPMDek5RXwtWqzIO1A99RC79TsD6NpxktP+c5YSyXsleKnMbSrfLjwF5G8Kgg7rJS+elohRO33felaNmWfNPl7SE7MQ0PfXENyUI/wDSKGL0yee/i/S8w1EUHkfcqZm910LxK9vsBuon/+gE5bW1PELoa1hHA+VWukc8xRddCWOtbwlONerlJ2MQhevM5JksD2Nm8gNTbe2lJdljx8/y2AESAJ6+1L1N1VxfLBNOFP9Lr6qclByIXEiWWm4ajN/0bgMJhaelcvdK0EpBdlEckeLMnbTg/X1b8AUfyQNnvNmqm1s6q4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(26005)(186003)(86362001)(9686003)(55016002)(83380400001)(107886003)(110136005)(54906003)(7696005)(2906002)(4326008)(316002)(38100700001)(52536014)(71200400001)(478600001)(64756008)(66446008)(33656002)(66556008)(66476007)(8936002)(66946007)(6506007)(76116006)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rpV0N7RVcYh73Fi28SivD7B//hwFrdDFGTdtdBb51ijraVmN4Uy3eJJ9spu8?=
 =?us-ascii?Q?Jx2rmqo4QkoKZ9QSp2dD89+EbwBfSRs/Xz5KnRNzI+ywCMcO8s1ZeE5Xx1qM?=
 =?us-ascii?Q?6WS11IwP0rmeHlUyZjoaluwtD3KexGDyvCgeJBIG8p7Ee4HSHeAR6V9NcFRE?=
 =?us-ascii?Q?7AQ1LQAvx8eOWyPwmIeuOZjWEdzoBtQOS247n1o0s3DKINNS+qIWMVeIBBlT?=
 =?us-ascii?Q?nzN1Z+eVvfPeD4GcHVpA/zxt5rKMYGYNXc0iC7QO7XHrVzO/rEgHii7qfH5c?=
 =?us-ascii?Q?KtNKpsVNcN8N+xvo8/zD43U+cC00U1CEAfLIiRBhk7O8h2WUBKO9uop3pY9C?=
 =?us-ascii?Q?7s+skuKZN5KOpXYg7oQFSfProKLPuZCgHF0O5/yuJlORbpQ1415nm7QGHua5?=
 =?us-ascii?Q?j/vbX9bt9qnAeg6RctEK0L0f0MgFHL4Lc3IvWQvqgsnrVvPc7/1hTCTdtTXQ?=
 =?us-ascii?Q?aJNdWUhbtx7jUEdyh4UvjO0jAcaJRlhnNglWO+2TqFFzNrk9New0VmS5fPOM?=
 =?us-ascii?Q?Rwz0DDdGLbzN0Bd+76pKk7daIKiooLi1h5yCcbHhq1hoLnZkkmAdLDMQK53Y?=
 =?us-ascii?Q?4IT7BTcjZMNWfRp4Vdt9EpuzUTLnFQFTUmqctMuhLNme4/jwZdkQ1E+St1jH?=
 =?us-ascii?Q?3juMfdPKJ6m69ZYlB2FG8wCTiYpr+J/7/17mGPaHr+pgGNy8MFSmmBuXSewP?=
 =?us-ascii?Q?Z0Gg8pYjtqe5A7HkyhnG6mXDyHYgIRKyeao5fHdG3Y7ISEaSA0YU+2r7IzlQ?=
 =?us-ascii?Q?9y9SiRSzfV5pFZA9M5aIkyqisOW/rvMygy7sJ7WJbonWw3xx8TajdyvbMcuw?=
 =?us-ascii?Q?PIJrOkeKfTRmapyLGms65mYARUO5WWqpJrzUYBhC1IZ+VwDB1bnGZ1CObRw6?=
 =?us-ascii?Q?ZJgoH5BUHrAcwdxCK0iy35tcknbB29TTXYmmMMWjiwUxz2Qoa5TvD7WpfPzz?=
 =?us-ascii?Q?t/nrrFGDATHduQjaDxeygYkc/sF6EDPsTMkzLj6tJPa+VYT/JS/F/C0hxJjG?=
 =?us-ascii?Q?7xy4FoRAoyrL/P5ABUqxHZ/E7T7oB5oNW4NnKx23be6SKPgyNT2+n0bI1x4s?=
 =?us-ascii?Q?BcLzay26cSDV3ETfkduFkOKyJzeyOcBAMfqyYtLmlo+dCmm/lASBrEkP6Hiv?=
 =?us-ascii?Q?bZCAda9QSnXijZrcwiVLhMsPiV0Jz/EF3RZY04RY7BX/u36u718jmMF8edjA?=
 =?us-ascii?Q?yZdHz47OFcSHLb2NORVPU1AOXbDP6xA5WF8dkmFPf3I12Z/fk0x65ER+kXWv?=
 =?us-ascii?Q?6cGWKfjqoZomJIVTgGF9MiNIWQRKxnAk+T6UzsVDzD5K8JWkQBdDd8vP4aOp?=
 =?us-ascii?Q?/rHAWIli3sBeFsGXDbd5UXHp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e216c2e8-11dc-4d54-c33c-08d8ee20b00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 17:25:43.1407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wd6/Ijz9Teiq0efcM6d94yI9P7xllBbxFWIGWqhSutcVrptqwZz7LI+p7vqKDumgxU+r8aHFvWSiyV6eGloM8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4448
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> I can only recommende everone to buy from a less f***** up GPU or
> accelerator vendor. =20
I would certainly love that.  This is not just a recent problem, it's been =
going on for at least 3-5 years with no end in sight.  And the nvidia drive=
r itself is closed-source in the kernel :-(  Making tuning and debug even h=
arder and continuing to add costs to NIC vendors other than nVidia themselv=
es to support this.

Back to the topic at hand, yes, there are a few misalignments in the ABI.  =
Most of the structures are carefully aligned.  Below I summarize the major =
structures and their alignment characteristics. In a few places we chose re=
adability for the application programmer by ordering fields in a logical or=
der, such as for statistics.  =20

In one place a superfluous resv field was used (rv_query_params_out)  and w=
hen I alluded that might be able to be taken advantage in the future to ena=
ble a common ABI for GPUs, we went down this deep rat hole.

In studying all the related fields, in most cases if we shuffled everything=
 for maximum packing, the structures would still end up being about the sam=
e size and this would all be for non-performance path ABIs.

Here is a summary:
13 structures all perfectly aligned with no gaps, plus 7 structures below.

rv_query_params_out - has one 4 byte reserved field to guarantee alignment =
for a u64 which follows.

rv_attach_params_in - organized logically as early fields influence how lat=
er fields are interpreted.  Fair number of fields, two 1 byte gaps and one =
7 byte gap.  Shuffling this might save about 4-8 bytes tops

rv_cache_stats_params_out - ordered logically by statistics meanings.  Two =
4 byte gaps could be solved by having a less logical order.  Of course, app=
lications reporting these statistics will tend to do output in the original=
 order, so packing this results in a harder to use ABI and more difficult c=
ode review for application writers wanting to make sure they report all sta=
ts but do so in a logical order.

rv_conn_get_stats_params_out - one 2 byte gap (so the 1 bytes field mimicki=
ng the input request can be 1st), three 4 byte gaps.  Same explanation as r=
v_cache_stats_params_out

rv_conn_create_params_in - one 4 byte gap, easy enough to swap

rv_post_write_params_out - one 3 byte gap.  Presented in logical order, shu=
ffling would still yield the same size as compiler will round up size.

rv_event - carefully packed and aligned.  Had to make this work on a wide r=
ange of compilers with a 1 byte common field defining which part of union w=
as relevant.  Could put the same field in all unions to get rid of packed a=
ttribute if that is preferred.  We found other similar examples like this i=
n an older 4.18 kernel, cited one below.

It should be noted, there are existing examples with small gaps or reserved=
 fields in the existing kernel and RDMA stack.  A few examples in ib_user_v=
erbs.h include:

ib_uverbs_send_wr - 4 byte gap after ex for the rdma field in union.

ib_uverbs_flow_attr - 2 byte reserved field declared

ib_flow_spec - 2 byte gap after size field

rdma_netdev - 7 byte gap after port_num

./hw/mthca/mthca_eq.c - very similar use of packed for mthca_eqe to the one=
 complained about in rv_event

Todd
