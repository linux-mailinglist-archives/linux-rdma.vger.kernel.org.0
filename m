Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E461681926
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbjA3S3S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 13:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjA3S3A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 13:29:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59F126DF;
        Mon, 30 Jan 2023 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675103240; x=1706639240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uy+nTPbU9GvszhzjSR/dNpzxRs5nL9IPA38PcUVYYl4=;
  b=ldfEnEuZ97iQDLgsHsurZiKGJWdU3XSLqagUJJ+IvaLhu491FKpPAvGX
   aEDMrwFsVXzhldQI2jemh+LlwFVxTu4n7SFECecZBPfUxCDv+BCiJbJSQ
   6BYzg5uNTLVGFuXfl3ZvumdYGXFE5QLlN1j/5I9DPs11oPmyyUS2QiNoQ
   7qMKYyWTZ63iTPaLU305tlSDYNFMF+KLGTfSQve5pcAV15MUnthMWL6e6
   lCJ7EKeG0onpT9Tg4hZLSmyOXo6iLKFLtSxeXIk47roYt4wnyqIRe3y+p
   tPYTjdwa02ycw862q0xaAHlwlq1CpRAgmEbwIORU0tVq3ps2eErVzzq8t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328912616"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="328912616"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657566435"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="657566435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 10:22:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 10:22:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 10:22:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 10:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js1IbE85qDsNl6/gLdbebEtmqhcN0NDvPFh1Egbc6v6G3BSLKWhh0aF+wW8K2w07fxjvB9JQUIvcy0sh3Uqj99dsmWgz7H41OQL6AepnRhEHTL+PWKf3dSdRKe+8WXBDzSfLhoT/zY0Uk6s9vn7bkYpr5ZktDUEvLDAACkKXfLO7hykqKsKwvkk/WYAejM/ZB1jaFj1a0HzhUKhvEzLp//1XZ6uiH+0HS2X3LHbEdL6up9YpOz9xVzM53tTC+Hg7d+DD0TODI9ZpQxlssO0IR3AVd8QkdJdk88Yh5oK5wQLHzUeA//ZeY1cJbdAKVAwp+sKfe+GkWhEp6quHsm5SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy+nTPbU9GvszhzjSR/dNpzxRs5nL9IPA38PcUVYYl4=;
 b=V6cb+6zppUC3+h3RpOmVoKRrtUmJZsXJDEpN9Sho48vYK02ZsAvejP1MBmqOOVi+OBHtyDgHVm43pji1TZowRzgsadUO50/TnXMfFehAOCUcR8QmD7D71eiGcJRYATqDnXkSbnuOHP1sMlYx1rS9x5mHN9Wp7GODRjGEqhyhx6wv4Yf8pATAfi6Fxrd1X2kKhPViim40d5XZ0ZBS0YYS9Xe86rgfj4VoKCRlHA8zKtNwHXvCcmCuDXwvxlzyNl+FrqWauAK2Ezm1u8xmc6r71J+NqHG2loOOojPkyh6W+5GKoNDQwoEC+Pa5q0ZJAK572cYA8eC5t4Sx8pF8l9N4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:22:29 +0000
Received: from SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e]) by SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 18:22:29 +0000
From:   "Devale, Sindhu" <sindhu.devale@intel.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devel@vger.kernel.org" <devel@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Devale, Sindhu" <sindhu.devale@intel.com>
Subject: RE: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Thread-Topic: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Thread-Index: AQHZLEri6x9HmTIRLkmMWtN2h/mbLK6rvveAgAatAxCABOX8MA==
Date:   Mon, 30 Jan 2023 18:22:29 +0000
Message-ID: <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
 <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
 <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
In-Reply-To: <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4953:EE_|MW5PR11MB5761:EE_
x-ms-office365-filtering-correlation-id: 73635863-5265-4546-2462-08db02eef225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z41wAijAKsny6GwmEKeOJdxXjy0B5xusuHuUaWwYHQ0Q9TSFiJx/Z54ZB+ec0BFC6/XEjlToNOPB5i+5Y1lZOW3qlqpVPmO91L7wB1rKgzcajkemHx0f5YBnyYJO0CmMXrarFvh833Rv7gMBq6ph9YSUvnysqfDSbq/hc/nD9bTWarACXggGh2RAfu/QUxLDMXZu3YXwD/ZgX1CoRfuKuqOfHT/J2sjpCyFUr0tpyJOOyIqS/owHyoqvB7At/zmNmvfNg6eTym0IDESgQkIptVy4BUxeS7S8ExRhvnVQwo2tcfgWrCmy7xwzPOpgCSsiqxcbv3ZB4nd2fJdam0c2nhJ8ZCilVsbgYlyMx5i+WDzP+Ei8kBH/CGONMU9wzaq/9RQ4JbdIke8KFrjm1Cp4Sve6KUjcDTl/Kxyzexc+o2EhjSwPfXUDcjkGQf6w5mU0UWeqQtLaGaQLn7x2xoujAb61ZY5c17gJvDpPsL5a6NnuESx2rv547xuxOo5CTDNL82ZZKAgVeJrHuFVQ7+qz2XLJlCFUp3xIFQHzyAg7sAFuQTLzl+fNTwjQoEJNBG+ppJYvI/RkhBhp1eeRjXiUMjO/OysG6uvFUrARc2iX6L47UBU/0pemGNjCK16V68GERyoS6da4xZVPLMRQio9GUzRKEp6+y5Q0+JYQgOLDPDZN+dL1wqNglsLCHSHWyi9B0hGGUKGlWmozvNtvyWYPqS0FJ52+rCAc+bgj00pTq4oTdCG3OmIpScg4IjjxSYqE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(86362001)(5660300002)(52536014)(38070700005)(83380400001)(82960400001)(110136005)(54906003)(33656002)(122000001)(316002)(55016003)(64756008)(66446008)(38100700002)(66946007)(4326008)(66476007)(66556008)(8676002)(76116006)(186003)(9686003)(26005)(7696005)(6506007)(71200400001)(478600001)(107886003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QytjY3NRdmhOTStFcjlNRzBLQm5MVWdxeGtFZU93ZXplTmRLWTFQbzdsTjNZ?=
 =?utf-8?B?dlZ1anpMTjl2VDdFSlFMeHo3WC91QzNHbUZkVWJEOC9zUm5aRGE1QlNRY3VB?=
 =?utf-8?B?ZVEvREswKzE2Z3M2U0I1c09NSlJJU3Z1L2pWanBJcnluaTFvak0yZGljbENx?=
 =?utf-8?B?YWdvVHovTDhiMTRsMnBYRW9QKytkV2FVUEt5a1htcTZPc29FSzZzUjhwUUw0?=
 =?utf-8?B?VXcyU2NWcmdhcW4vK0o2SGVZOTMwQTRnZStBQ3Ric1RtMzIrVFM2VUtsOC9D?=
 =?utf-8?B?dThXQ2VMdDFzRzVVNlBJeE1zWmV6V2VBZ3pMUnIyRUozbE11aHRoUklXOU5i?=
 =?utf-8?B?UkJyYWN1RUEzOXpoR3FPSmhRTHNwcHltNTVYUG5HTDg5MXRseHJEVjVOcUs5?=
 =?utf-8?B?clVKU0ZQejdoam1NWEVRWVhTRndmSCtUZlUyRzRxVUZVNmd6N1VFcE1IS091?=
 =?utf-8?B?T1VveURteHNRczVLL0xNUXU4SytSQzh1Ny9ySlZQME5rZVFubFQra3p3YjMw?=
 =?utf-8?B?SFF5OVNuempMZHYxcisrWVRWUWoxTGJDaHdWbXZHV09YRzV0R2VPWS9jaHhi?=
 =?utf-8?B?bTBETSt5TVhJRGdGRC9saUwxck1xNTgxRW9pQUlMOHNQbkgzL3dmVVhCUWxp?=
 =?utf-8?B?Tm16Nkd1VnloL01IRkhaZnNLOW0xZWFSRTRVTEp5MHFveGs1V0dvd0JLRXpx?=
 =?utf-8?B?NUNTU21XWEhqdytGVXQyVSs2T20vOTNHRnhYQStFRlVKR0paNUZWMnc5MFZz?=
 =?utf-8?B?Uk8zbEQwTDEyb29kdVc0WnhLWDRRRDQrQ2MxaVcwYXl4L0hvOXl3SjlQM2E0?=
 =?utf-8?B?Tk42Wlo2bGpqMGlUaUQzelNiMXB3bEVCMjhzUVZGOUFkK2FGNVgwTFNnYXNI?=
 =?utf-8?B?dmxlU0Yyb0IxdXZPUDV5QVgzY2Nsdm1UQTJFSXdQK3ArQmZYVFNIQk42OTNN?=
 =?utf-8?B?R1lwRDlXb1RiTXJpMlluZmR5QWdBbmI3MlFDK01aVlRidDV6RjNsY1VHOThT?=
 =?utf-8?B?OStITzM2NG9NcERYd2F2UTNpRlR3Rjk5TGhUd0llaG5JalViSmhYeXUzMkZW?=
 =?utf-8?B?Y1J3R1BPQXNWODA1bUhRMW5MbWFkWXZUR0hsK21ZbDVBNGl4NEpTcnFkdHZS?=
 =?utf-8?B?a3lQUWdERERkc3l3QkxTRlF2Ny9UaDBCOFUzYUkwcGRtbGVwOTIxNVZFeko1?=
 =?utf-8?B?ZWNTTnVDVUNkMmVmbWFwajBDcFhYdzJrSFQ3R0FMMDMvQStndWt3VDdaOTJG?=
 =?utf-8?B?R2pISDdJOGRSOUFiU3lVVWVpRFhQbGZxTW1VMDVNbnZudkxOM3dmZ1pCNitk?=
 =?utf-8?B?NGVuODY0aWM4czVJTDhPTDB3TlUvMEpiR1lvc240Z1QzQ3hFTHhZZENUOWFR?=
 =?utf-8?B?eW5rQ2g0Qnp4LytKNHVWaHVxbGR3NVJVakZrTWxCT29OLzRLc25sNUxqL0JC?=
 =?utf-8?B?K0MxWkwydks2eXl6by9tb3R3d3ZJTzdnL2ZvNndpT3UxTkx1ZXRDWE5CMmtn?=
 =?utf-8?B?OVZucUllUFdMNmZJaTlpaXpscXdENGlieXYzRTRmZXdtaWFDWUFVRmdkWWZ6?=
 =?utf-8?B?Tmg5QklBTDE0STdaZVdKY2FGdHhXU0NuTGg5VEFac2lxK1pla3JTcENtY204?=
 =?utf-8?B?WDdqc2lLc1JoMkdGRHluUkhPSzNjc1hDRklFNE1UWEhsdnVKdk9PMVNDdkpr?=
 =?utf-8?B?T0FUOXltUW9PdTZyeDVQMC9iODVoaXpuZXMvTldYdWtJRjBlWmc1aDF3dG91?=
 =?utf-8?B?NjN6M0JtVWEwdVQ2YzR5R1AzL1FZdmxQaUVsR0VFd3lDMFlDbHVkbGFJNWFX?=
 =?utf-8?B?QnJraitTekhqdkxkTDY1dXZ3SzZ4ZytVTUlTVXg2NGhZczBkaEczc25jNkVz?=
 =?utf-8?B?aUE4b3lKdEtaUDh2Sm5OcFdWQ0VIVUdnSmZ4V3ZHcktTTkw4dml1WWxJUzA4?=
 =?utf-8?B?RXgxMlZHazV5RTdEQXJOdk1iS0ZRZHEydHRIajgrNWhxemszU2M2aVlna0Jp?=
 =?utf-8?B?bzE1b25LZjduQkJ0TVBrTmdoL3B2bDBrYTNkZlBZTlNiREVadzBMbGtqaEpp?=
 =?utf-8?B?czFYeHBwajBlNE5oeEJXa0lBV3VyODlMcnZMYldRd2M3R05jNDFKUGtPYmN4?=
 =?utf-8?Q?mJsbqOIueG/TnnxzG2HOonFvE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73635863-5265-4546-2462-08db02eef225
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 18:22:29.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNrnMb1z+2nR15SFoxAJmSGE+dt+hv3LphqDCE5Fy6HBKfpcQ43jT4KiYCkFWa92uRQYCp6blA/SfWuHboDPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBmb3ItcmNdIElCL2lzZXJ0OiBGaXggaGFuZyBpbiBp
c2NzaXRfd2FpdF9mb3JfdGFnDQo+IA0KPiANCj4gPiBGcm9tOiBNdXN0YWZhIElzbWFpbCA8bXVz
dGFmYS5pc21haWxAaW50ZWwuY29tPg0KPiA+DQo+ID4gUnVubmluZyBmaW8gY2FuIG9jY2FzaW9u
YWxseSBjYXVzZSBhIGhhbmcgd2hlbiBzYml0bWFwX3F1ZXVlX2dldCgpDQo+ID4gZmFpbHMgdG8g
cmV0dXJuIGEgdGFnIGluIGlzY3NpdF9hbGxvY2F0ZV9jbWQoKSBhbmQNCj4gPiBpc2NzaXRfd2Fp
dF9mb3JfdGFnKCkgaXMgY2FsbGVkIGFuZCB3aWxsIG5ldmVyIHJldHVybiBmcm9tIHRoZQ0KPiA+
IHNjaGVkdWxlKCkuIFRoaXMgaXMgYmVjYXVzZSB0aGUgcG9sbGluZyB0aHJlYWQgb2YgdGhlIENR
IGlzIHN1c3BlbmRlZCwNCj4gPiBhbmQgd2lsbCBub3QgcG9sbCBmb3IgYSBTUSBjb21wbGV0aW9u
IHdoaWNoIHdvdWxkIGZyZWUgdXAgYSB0YWcuDQo+ID4gRml4IHRoaXMgYnkgY3JlYXRpbmcgYSBz
ZXBhcmF0ZSBDUSBmb3IgdGhlIFNRIHNvIHRoYXQgc2VuZCBjb21wbGV0aW9ucw0KPiA+IGFyZSBw
cm9jZXNzZWQgb24gYSBzZXBhcmF0ZSB0aHJlYWQgYW5kIGFyZSBub3QgYmxvY2tlZCB3aGVuIHRo
ZSBSUSBDUQ0KPiA+IGlzIHN0YWxsZWQuDQo+ID4NCj4gPiBGaXhlczogMTBlOWNiYjZiNTMxICgi
c2NzaTogdGFyZ2V0OiBDb252ZXJ0IHRhcmdldCBkcml2ZXJzIHRvIHVzZQ0KPiA+IHNiaXRtYXAi
KQ0KPiANCj4gSXMgdGhpcyB0aGUgcmVhbCBvZmZlbmRpbmcgY29tbWl0PyBXaGF0IHByZXZlbnRl
ZCB0aGlzIGZyb20gaGFwcGVuaW5nDQo+IGJlZm9yZT8NCg0KTWF5YmUgZ29pbmcgdG8gYSBnbG9i
YWwgYml0bWFwIGluc3RlYWQgb2YgcGVyIGNwdSBpZGEgbWFrZXMgaXQgbGVzcyBsaWtlbHkgdG8g
b2NjdXIuDQpHb2luZyB0byBzaW5nbGUgQ1EgbWF5YmUgdGhlIHJlYWwgcm9vdCBjYXVzZSBpbiB0
aGlzIGNvbW1pdDo2ZjBmYWUzZDc3OTcoImlzZXItdGFyZ2V0OiBVc2Ugc2luZ2xlIENRIGZvciBU
WCBhbmQgUlgiKQ0KDQo+ID4gUmV2aWV3ZWQtYnk6IE1pa2UgTWFyY2luaXN6eW4gPG1pa2UubWFy
Y2luaXN6eW5AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE11c3RhZmEgSXNtYWlsIDxt
dXN0YWZhLmlzbWFpbEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hpcmF6IFNhbGVl
bSA8c2hpcmF6LnNhbGVlbUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2luZmlu
aWJhbmQvdWxwL2lzZXJ0L2liX2lzZXJ0LmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKy0t
DQo+IC0tLS0tLS0tDQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvdWxwL2lzZXJ0L2liX2lzZXJ0
LmggfCAgMyArKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3Vs
cC9pc2VydC9pYl9pc2VydC5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvdWxwL2lzZXJ0L2li
X2lzZXJ0LmMNCj4gPiBpbmRleCA3NTQwNDg4Li5mODI3YjkxIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC91bHAvaXNlcnQvaWJfaXNlcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC91bHAvaXNlcnQvaWJfaXNlcnQuYw0KPiA+IEBAIC0xMDksMTkgKzEwOSwyNyBA
QCBzdGF0aWMgaW50IGlzZXJ0X3NnX3RhYmxlc2l6ZV9zZXQoY29uc3QgY2hhciAqdmFsLA0KPiBj
b25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtICprcA0KPiA+ICAgCXN0cnVjdCBpYl9xcF9pbml0X2F0
dHIgYXR0cjsNCj4gPiAgIAlpbnQgcmV0LCBmYWN0b3I7DQo+ID4NCj4gPiAtCWlzZXJ0X2Nvbm4t
PmNxID0gaWJfY3FfcG9vbF9nZXQoaWJfZGV2LCBjcV9zaXplLCAtMSwNCj4gSUJfUE9MTF9XT1JL
UVVFVUUpOw0KPiA+IC0JaWYgKElTX0VSUihpc2VydF9jb25uLT5jcSkpIHsNCj4gPiAtCQlpc2Vy
dF9lcnIoIlVuYWJsZSB0byBhbGxvY2F0ZSBjcVxuIik7DQo+ID4gLQkJcmV0ID0gUFRSX0VSUihp
c2VydF9jb25uLT5jcSk7DQo+ID4gKwlpc2VydF9jb25uLT5zbmRfY3EgPSBpYl9jcV9wb29sX2dl
dChpYl9kZXYsIGNxX3NpemUsIC0xLA0KPiA+ICsJCQkJCSAgICBJQl9QT0xMX1dPUktRVUVVRSk7
DQo+ID4gKwlpZiAoSVNfRVJSKGlzZXJ0X2Nvbm4tPnNuZF9jcSkpIHsNCj4gPiArCQlpc2VydF9l
cnIoIlVuYWJsZSB0byBhbGxvY2F0ZSBzZW5kIGNxXG4iKTsNCj4gPiArCQlyZXQgPSBQVFJfRVJS
KGlzZXJ0X2Nvbm4tPnNuZF9jcSk7DQo+ID4gICAJCXJldHVybiBFUlJfUFRSKHJldCk7DQo+ID4g
ICAJfQ0KPiA+ICsJaXNlcnRfY29ubi0+cmN2X2NxID0gaWJfY3FfcG9vbF9nZXQoaWJfZGV2LCBj
cV9zaXplLCAtMSwNCj4gPiArCQkJCQkgICAgSUJfUE9MTF9XT1JLUVVFVUUpOw0KPiA+ICsJaWYg
KElTX0VSUihpc2VydF9jb25uLT5yY3ZfY3EpKSB7DQo+ID4gKwkJaXNlcnRfZXJyKCJVbmFibGUg
dG8gYWxsb2NhdGUgcmVjZWl2ZSBjcVxuIik7DQo+ID4gKwkJcmV0ID0gUFRSX0VSUihpc2VydF9j
b25uLT5yY3ZfY3EpOw0KPiA+ICsJCWdvdG8gY3JlYXRlX2NxX2VycjsNCj4gPiArCX0NCj4gDQo+
IERvZXMgdGhpcyBoYXZlIGFueSBub3RpY2VhYmxlIHBlcmZvcm1hbmNlIGltcGxpY2F0aW9ucz8N
Cg0KSW5pdGlhbCB0ZXN0aW5nIHNlZW1zIHRvIGluZGljYXRlIHRoaXMgY2hhbmdlIGNhdXNlcyBz
aWduaWZpY2FudCBwZXJmb3JtYW5jZSB2YXJpYWJpbGl0eSBzcGVjaWZpY2FsbHkgb25seSB3aXRo
IDJLIFdyaXRlcy4NCldlIHN1c3BlY3QgdGhhdCBtYXkgYmUgZHVlIGFuIHVuZm9ydHVuYXRlIHZl
Y3RvciBwbGFjZW1lbnQgd2hlcmUgdGhlIHNuZF9jcSBhbmQgcmN2X2NxIGFyZSBvbiBkaWZmZXJl
bnQgbnVtYSBub2Rlcy7CoA0KV2UgY2FuLCBpbiB0aGUgcGF0Y2gsIGFsdGVyIHRoZSBzZWNvbmQg
Q1EgY3JlYXRpb24gdG8gcGFzcyBjb21wX3ZlY3RvciB0byBpbnN1cmUgdGhleSBhcmUgaGludGVk
IHRvIHRoZSBzYW1lIGFmZmluaXR5Lg0KDQo+IEFsc28gSSB3YW5kZXIgaWYgdGhlcmUgYXJlIGFu
eSBvdGhlciBhc3N1bXB0aW9ucyBpbiB0aGUgY29kZSBmb3IgaGF2aW5nIGENCj4gc2luZ2xlIGNv
bnRleHQgcHJvY2Vzc2luZyBjb21wbGV0aW9ucy4uLg0KDQpXZSBkb24ndCBzZWUgYW55Lg0KDQo+
IEl0J2QgYmUgbXVjaCBlYXNpZXIgaWYgaXNjc2lfYWxsb2NhdGVfY21kIGNvdWxkIGFjY2VwdCBh
IHRpbWVvdXQgdG8gZmFpbC4uLg0KPiANCj4gQ0NpbmcgdGFyZ2V0LWRldmVsIGFuZCBNaWtlLg0K
DQpEbyB5b3UgbWVhbiBhZGQgYSB0aW1lb3V0IHRvIHRoZSB3YWl0IG9yIHJlbW92aW5nIHRoZSBj
YWxsIHRvwqBpc2NzaXRfd2FpdF9mb3JfdGFnKCkgaXNjc2l0X2FsbG9jYXRlX2NtZCgpPw0K
