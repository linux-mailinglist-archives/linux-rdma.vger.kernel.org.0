Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44187A24E6
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIORfg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Sep 2023 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbjIORfd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Sep 2023 13:35:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D522D4E
        for <linux-rdma@vger.kernel.org>; Fri, 15 Sep 2023 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694799272; x=1726335272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nY+PlcKO+XBjLv+aKH/6KZH7Nh7ZP8/HaMPzVGiGl90=;
  b=OytteCQwrlFTEmCfGuMfn6d8MAq2/JTR5xFUH1hxyJ9q2ZmbOQCrpD2x
   mVO20A8ttIiedyqmJsnq0Cxe0KCacHqnTVBYigDlEBaeY6fvg9WoYyxQv
   bUOORuwYMqvTP7GoXn0XY32yFR5lDZqlDAH97WRZ27unuVHm23S09DXBe
   biEuPLjs+yOFgM43BSqoVe6SaCB63AXN/kmY+BWKkASuC5qcsE4mW3M9N
   zGVXK/797HlpjPO4CqMgvr5hK+4s6cmArhcKZOZl7D7bSGHZJbJRkohNE
   DgUTq9ZcnljDQHt50MQQdVDVVxr5lCnd4H6+El10In71dL+kZBkFLJtY4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465664149"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="465664149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="918722654"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="918722654"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 10:34:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 10:34:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 10:34:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 10:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfTV4OWf5oP/FKbk96A5qTHbq5iOh/Ag9W1DcLgDGSJJNq56nEsDm7l+g2lTTb5NgXU6/4AG3Vzrf8mdpfX9zKLYlebEHPEPzfTnKJYliNbv2G+PEZMjv/TIcZ6CheUodMbOaI7mvSbkyUtXKzflr9PS6ZgJXf/8PJkXdGwCPjsUwIRbuAtadYpuANcjc/XVPaqikNkcDbeeT3EEsgvWDcnHvhvFz1LaAuWDBqS6iw7dWNYeu3s8EvFVdFAnfKeRWJwY5sCP48WvDrWIkU8F0ma1BgI6gpqytIjr90y58rf7jG6awlEzkivU/tzEIbppAufQbcExUgIlUaD9ywmKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY+PlcKO+XBjLv+aKH/6KZH7Nh7ZP8/HaMPzVGiGl90=;
 b=BCgL+4ZgKW5S+3xleYfoVjG+wNkEDf6bJoFDK1SKFZZbc0sAACisiHC8+bKdGnsXA5Lc5JVrBEEFpSXY/DC/fCWAw3io+WSo6rohjzW6u/432ZwBP1bEygxlsGyoGksvctR7A0PNx8trhVcR50Bv2QnHh/WS8jmd9/ir3a5H7J/YzZLyRCg1ssuwd2CHtv56+bSCQSRURr5EIWx8eeH8+zIBMYQWP2lwPb7UW1yNYi0qkF5FiL1/eJLL/g3MJaRFIxf4LQR43Lfrn3vvPn+11ZrcfRfSFTIFNCmcp4zJbq17tuDa4M3kG/BAJBU08og0oFcYMoHeHHIIc+rkN1SaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 15 Sep
 2023 17:34:29 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::92e2:144f:f927:128b]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::92e2:144f:f927:128b%5]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 17:34:29 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "liujian (CE)" <liujian56@huawei.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Barrera, Ivan D" <ivan.d.barrera@intel.com>,
        "Bednarz, Christopher N" <christopher.n.bednarz@intel.com>
Subject: RE: [PATCH for-rc] RDMA/irdma: Prevent zero-length STAG registration
Thread-Topic: [PATCH for-rc] RDMA/irdma: Prevent zero-length STAG registration
Thread-Index: AQHZ0eMkE+JT7thsfUyo/iyRJow8kbALuS8AgA1YaxA=
Date:   Fri, 15 Sep 2023 17:34:29 +0000
Message-ID: <MWHPR11MB00297A4032276F863430D9D2E9F6A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230818144838.1758-1-shiraz.saleem@intel.com>
 <9a9ee4b7-b378-4aeb-6e23-02d2f6dbaa9a@huawei.com>
In-Reply-To: <9a9ee4b7-b378-4aeb-6e23-02d2f6dbaa9a@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CH3PR11MB8751:EE_
x-ms-office365-filtering-correlation-id: dd035ba1-29c1-47a0-0d41-08dbb61203d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ys5EQt6lCjRGdaPz0Lhaz0p3lu+nvPzoTaG31GxL+KhDLY968xFrcQMtKqFDqZGOLF1gBXdqtDtJyZS/qTdWkraqbpQRNiGxUB3MLZgyccyzdzVkaiTGTBwJEmbQv04AAu+E53lz8Xjokoi+4QaNvER9J33mxmxMm0y+UIB+HSGOjNtu7ew78v14sfDUR3RIvMTa63QxfTQFi1tHTCom01FA3d0euGoZQ94TZR1dAyW5tChk4ostijORFxZDpxN+jPS3eie0No5Ql+Aq3w/9AfZnMCLFXq/SOajTnHeZo/GNkMzh/RtOLDygXb7hIp5PNRjsfR8IDig5HREMseMPcG775s/KBwndQKlj26G2osMilbzW4W36xvIFXhHOCdmHw9uTA4y29N2qyMeqCW3yaLJvpiGyfzrI3C52i8yhGtB6JyzEKfYTLxagWByabrZmywcMZKK/N+tPVJWbLXslomLfCjTG31hDo4Nob7H0/9cH7sDdXmI4DfvdLMoe63RhEDxGinXy/s11JK2QLgTmeTEkykoIBoRk86dCItzCBNgMtVcxO0jEACY1ZVj4EjwnfIsnkDrUoMV6Mtn3YJN5JOaDA0ZHdUgyFkgvQ3RExyLnhrx0ReA5UDXps1+kadCv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(38100700002)(86362001)(9686003)(107886003)(71200400001)(53546011)(38070700005)(478600001)(6506007)(122000001)(110136005)(83380400001)(76116006)(82960400001)(26005)(66946007)(7696005)(66446008)(33656002)(2906002)(316002)(66556008)(55016003)(5660300002)(4326008)(54906003)(64756008)(41300700001)(8936002)(8676002)(66476007)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzN6MmF5Y3JpS3pxSDJ1RXhraURRVnNjK0cxeEtwaW5wNytycEVIN05qYjVF?=
 =?utf-8?B?SWNPbjZ4cTk0QVFHUG10Q2lvR3gvRC9URzI5K1VtZk9jbC90bTJObHhMTkYv?=
 =?utf-8?B?THRtZms3UmxrR09aMWVER3ByVmhkTVRzdDNNV3ora1BJMERrdjlqbnFaMmxp?=
 =?utf-8?B?bzJHNENMOEFOVmRXTndjVitvQ1BhUndhYnFPWTU2VzdHcVdySmtjZmRrWk80?=
 =?utf-8?B?OHk4ZVFCZURvRlpqS3RHTU5Za0gxeEw1aVVqaElkWHRZdVphajV4bmNOaHFa?=
 =?utf-8?B?cXZTdGQ0NnFmazdXNjhIWjZkakZTQXIzRndBQ09WNFB4YjlGNVFUbzVUeml0?=
 =?utf-8?B?M1ExbjVJNXV1NmttVHkzVHJtTVhlVFdweVBCajNEalg5QkdYblFieWc5QTRk?=
 =?utf-8?B?a2tmN3BHL3RXK3hEVThzSUhjWmFKRjFTRmVFckx4NjUzOGgwcVJKWkl0Q0kz?=
 =?utf-8?B?cDBQWk5wejh5MmYycHNDQUlKT1ZWQjRZRm1TUHQ3Rm1DY1lSTEMyY1ZhVGQ2?=
 =?utf-8?B?UW9FN2QvTVQrTm5QWFJEUFF5SmdXVDRVQlY2cnZkMytWNW1ZdnhodW9IdlJj?=
 =?utf-8?B?ZVhDOWxSNEZpdUUvdlhvZW0yVTlibmRrZkVXd3UyTGtXY0FrQWs5andSeWRB?=
 =?utf-8?B?OUF6d2ZGNDJXaGZrdDNLWkJhd2cvVFp2cWZpQTVLUUJwS3ViUDY5bDJTbkZ3?=
 =?utf-8?B?d1BUS0M4Qnhzb3pLTDJKL3VsRG44ZUdoS3Zaazh1RXV6c2cvaUk2S0FucjI0?=
 =?utf-8?B?Rnp2V1dydElPUzRJOVhzUlk3Z1JLZDVOYVhaNWpJWnB0RjdHWk1ZUzdwdWlr?=
 =?utf-8?B?RFA0d1NrbllHSldqVi9MbVdGcXVYcEQ4dHdOMnJZeVdteFBUd3ZTZkRLY2E5?=
 =?utf-8?B?dlpiSS90QWJDWEd2ZHJ1M21pT3RERUpKMThaZkFOYjdINGRsemxjVXFIUjhk?=
 =?utf-8?B?aS9XNEErYWp2WVhqTHFxSmVpZTNUdmhLWks3SDV3NzFIQ3J4MGFYemR6NWk5?=
 =?utf-8?B?azJSWEZNZTd5SmpMUUozY2VpaXkrdTVWcVczc3ZEQ3o1b3lTNGVIQzd3Uzk0?=
 =?utf-8?B?MGVyRW9SRjZJcDFvUjZQQ1U3OUxvUjAxT1pvallyN092YUE0a3VSUXljRjlW?=
 =?utf-8?B?R29HTGU2czhLeHgrTTRIOGlRR05WNWpLSkoxcUlFQjErcGdyemY1Sm4rMElv?=
 =?utf-8?B?ay8rMmQvQmFKeXdyMk1MNHhpL0t5bGVWcUIzRTg3RnFPTkJZbmxOYzZEUmg0?=
 =?utf-8?B?djBuQUNkNjB2Nm1vM2VaM2dTV2toNFBLbFJQK1dtWGxtWmJwS3crcnZ6TEF0?=
 =?utf-8?B?ODE5Sm4wZ3NCNzNXVi9mT0RkT1BKUEh0a3VQZDlXWkErSFdUaS8za2Z2Y0du?=
 =?utf-8?B?K1JTcmdEMnB3aEgrcnk3VGVBS25hWkt2VWN2aFdaQVJ0eUpOeDE4ZVhIcExM?=
 =?utf-8?B?ZnJBZldVVVBTckt1VVljVWlFWFRWWmxtTGt4eGxQc0JDQTFHSm1TbDdGVEFq?=
 =?utf-8?B?OW5sTE5OejVNdWNZS1dQYTZRSWxUUVRkbzlCMml4UzYwOXRlWGRvWmkzUWQv?=
 =?utf-8?B?T0l5MWtDNmdnSDdvRGxxZVZ3dnBUaCtpT3JlZ2hjYSsxdllxNUdRTEw1dzVK?=
 =?utf-8?B?RHJCUDNwdXlnV2pkNi82d21rV1MrTEpMWWFoajg2ZU1XSThORDc5MnlLcmkz?=
 =?utf-8?B?UU95MEVBeFZlbGlIc21qdG1Hb1VrazFJc1Z1bERlc0E5NEl5N0lhS3lmUzk4?=
 =?utf-8?B?RVBEVUFDaTZ1TXF5SlB2TjRPNHhlVi9lL01nUXN5MGc3MXZYUWRDM2RqRTRR?=
 =?utf-8?B?SVhpVzUvY1hVRlE5SkZjc1FvR3NvVnBubGhvbGc1NjJMZkVBNUUyM3hQNE1n?=
 =?utf-8?B?QVhKUEoyanphR1JXeWFlWVdvZlpKOE9PSEdoT2dVbjlxWVQ4SmZPU3Vpdm4r?=
 =?utf-8?B?S0ZTWWpERk1aSFlPZ3JWOFJSdFZHMm1nd0xSMFRWZmJ5VmN4WDFwM3VnU2tW?=
 =?utf-8?B?bkpjSE5EYkE0eUNKaXoxRENvdmtudXQvSWgzTXg0bm1vK0gvcVBCZDJaYzE0?=
 =?utf-8?B?R0lCb2RudlhvM2xwMThEaEdTZVh4M3NheGVsNHpYTnl4QjFxbzEzbjRHMlNV?=
 =?utf-8?Q?Dy0FTpSBlkAahE5WBHQDvoKnO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd035ba1-29c1-47a0-0d41-08dbb61203d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 17:34:29.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXLoJi3S0GKyclEgz3tUU425bbwDxKxfFU7ebzA2741FX3NJeVgfzb4FhMwpD7ZEmkQBytIUmffk3K6NfA31EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIGZvci1yY10gUkRNQS9pcmRtYTogUHJldmVudCB6ZXJvLWxl
bmd0aCBTVEFHIHJlZ2lzdHJhdGlvbg0KPiANCj4gDQo+IA0KPiBPbiAyMDIzLzgvMTggMjI6NDgs
IFNoaXJheiBTYWxlZW0gd3JvdGU6DQo+ID4gRnJvbTogQ2hyaXN0b3BoZXIgQmVkbmFyeiA8Y2hy
aXN0b3BoZXIubi5iZWRuYXJ6QGludGVsLmNvbT4NCj4gPg0KPiA+IEN1cnJlbnRseSBpcmRtYSBh
bGxvd3MgemVyby1sZW5ndGggU1RBR3MgdG8gYmUgcHJvZ3JhbW1lZCBpbiBIVyBkdXJpbmcNCj4g
PiB0aGUga2VybmVsIG1vZGUgZmFzdCByZWdpc3RlciBmbG93LiBaZXJvLWxlbmd0aCBNUiBvciBT
VEFHDQo+ID4gcmVnaXN0cmF0aW9uIGRpc2FibGUgSFcgbWVtb3J5IGxlbmd0aCBjaGVja3MuDQo+
ID4NCj4gPiBJbXByb3ZlIGdhcHMgaW4gYm91bmRzIGNoZWNraW5nIGluIGlyZG1hIGJ5IHByZXZl
bnRpbmcgemVyby1sZW5ndGgNCj4gPiBTVEFHIG9yIE1SIHJlZ2lzdHJhdGlvbnMgZXhjZXB0IGlm
IHRoZSBJQl9QRF9VTlNBRkVfR0xPQkFMX1JLRVkgaXMNCj4gc2V0Lg0KPiA+DQo+ID4gVGhpcyBh
ZGRyZXNzZXMgdGhlIGRpc2Nsb3N1cmUgQ1ZFLTIwMjMtMjU3NzUuDQo+ID4NCj4gPiBGaXhlczog
YjQ4YzI0YzJkNzEwICgiUkRNQS9pcmRtYTogSW1wbGVtZW50IGRldmljZSBzdXBwb3J0ZWQgdmVy
Yg0KPiA+IEFQSXMiKQ0KPiANCj4gSGVsbG8sSSB3b3VsZCBsaWtlIHRvIGNvbnN1bHQgdGhlIENW
RS4gVGhlIGRyaXZlciBjb3JyZXNwb25kaW5nIHRvIHRoZSBrZXJuZWwgb2YNCj4gYW4gZWFybGll
ciB2ZXJzaW9uICg8IDUuMTQpIGlzIGk0MGl3IGFuZCBoYXMgc2ltaWxhciBjb2RlIGxvZ2ljLiBJ
cyB0aGlzIENWRSBhbHNvDQo+IGludm9sdmVkPw0KPiANCg0KWWVzLiBJdOKAmXMgYSBwcm9ibGVt
IGluIGk0MGl3IHRvby4NCg0KU2hpcmF6DQo=
