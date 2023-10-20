Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE767D071A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 05:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjJTDrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 23:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjJTDrN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 23:47:13 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E3C0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 20:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697773632; x=1729309632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zwc+jcbJGIoYrqKoQYvSqTVq94+Csb7EZDIiLy++kvk=;
  b=LBfKDwYxLr4jclx2P0Kchr0EpQNttwa/40mE/CyLOUecxgZD/NvW/sSI
   2PZt6Jh8LWkeS3uB/XapJJg8at/+SVBkfAJlnJMmVNa0ewjuKd5MFBeDH
   jB1Trfzu0TdcEKm63ADbuZVi3OwzvNi9c48lGwoKITMgGVgiREbI4I+p+
   szvdGppmnZsQVLebHl86IEXCe3SEu+YRsGvgoJOJKYZ64gim0gktK/E+Q
   qEwJ17MYlSTt1JWw5Q2e9TysLMURAKLlMYjlhPvDmirTnf53ZnPOfRgvv
   WCsIBl/rFBqrso/l7k//EQonoO5rAHD+H5i8G8lRQ716fAP6Va86w6NvF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="99927606"
X-IronPort-AV: E=Sophos;i="6.03,238,1694703600"; 
   d="scan'208";a="99927606"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 12:47:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLLHTSFTzB5xu1exdBoq7dnJlS5aAULVZ65/lglai7RLuO92lj39xCzRcyOymyryls2J0uSy3sZ8TT32PuDGJq2kp9BGWuYnayiBG0eu0rKbqQiRUgv5XLr9vZzvD+8BtD5FP9WkMMFqcDgLXbW60QkirH+CWgR3KBoM1Y0UDkB7DJ64Y1fecHYHfDnHM1J9VCny5yQSDIXd0ThtcQxu1nwGO1LyaL/jBzB3Bn9OEq+QmGqvalnw9UZre1hNF0VXq9sT1IvGtaGgpggMhTR9zxmVz4WjljCFlDWoEDU9FvU5L3K3bKGTL2YFGullvvOK/o4708VP8iZ+dCqr4+9s7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwc+jcbJGIoYrqKoQYvSqTVq94+Csb7EZDIiLy++kvk=;
 b=ZExGg7XEXxJa6v9IYaHX2o0Ufz5cClfUj2X3dSH8OUHiqiBbDcbAnceyhwel756TtifLEEoBSrxqtyqOIdXaPAgUUIZuL5gwuiu9iQ+w/YfF6VRahMiuT373ZszJ4cnDoJdNhWqHpTl4MrpEricFglfl6uJIiBAxhpxF446zXV1L9BdN3T3IGxtIvj8LZvuzI+slQy4h/wWBFyBDdvIm9rHGeKOoQPwWAcBMRrRKEq2ySLDMlofkHe2XP6wIUxDPGmQPwCJI3A+R720MWgq6mZDouli45ZoRZqSOjJHhJ5g+o9ve0WhsNO4+pcMx4dg1u4eWO8FgIqj1mLl1nk82BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYWPR01MB11185.jpnprd01.prod.outlook.com (2603:1096:400:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 03:47:05 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 03:47:05 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL9IGMvq9FNfkyOpi5jnlhbgbBHnzQAgAp2EoA=
Date:   Fri, 20 Oct 2023 03:47:05 +0000
Message-ID: <a6e4efa6-0623-4afa-9b57-969aaf346081@fujitsu.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYWPR01MB11185:EE_
x-ms-office365-filtering-correlation-id: 73f1b9aa-af01-4726-df83-08dbd11f3a2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIzfL6f0eBWAGLibHoqP51eVhNZdxkJqkgt1U/f1crOnCDoO7n5ghr6u2qafwSoYpdOMR66IhpcMCiTGghy07pN+SLuf0i/AHS0FacobM1KTe+JsHQXer2utqtmvFT4Ik/4VAWhnKzafU6v0/fVcFEzlrTY60w1gG6JSSJ+x/EsMVnBdJYpkUQA+lQj8yiPOGWvQgV2bB6Jqvo8qsI3YlQlATWWIduKt/30Lehb+kYyLrTdvGAMcXhwG5AFngKfVHnJcEE0uqL7/sMqs/GDEGWNdg4AaHpxj8OhVdaZIT/fuoNH/r3wZsfEcA+m6r7CwSk+rEfjfUxbLMmm9K9aYwRv5DKsBSgc8NykrA9Zh3WWFi9ep/CNnYcONuxGD+Kc3eExICdWoYhgjm/Or0b4ArRsLmA5hx8OnIlk4fl2CMnN50Lshj8AuOBDW+46uz7Fin3qlsYd53sEUpxiIueOs8PCJdm1/epsPoMvHZyhRF99wdegKStyV/SBkOFp1jGHvUg3nU+phNCgjKYVksUKIgF2wMWP34GDr0OtJu4TVVRxaHU1/Qt8EZ5vwN2RH2wdBet8kXBuaVheC6Ed7BleGcNoZa/Nio3g9vLM76zDY0sogbmpvKH0nt7P+vmI4O5fbXF3eArYl2oHiragbrOaaog6ONt4SQeZh4I03YSMz9sEjubb+HK2FW88OwKUG9Fo76yq6HD/LP3HILWt0cBFFsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(1590799021)(1580799018)(66899024)(66476007)(66946007)(91956017)(66446008)(76116006)(66556008)(110136005)(64756008)(316002)(54906003)(71200400001)(8676002)(8936002)(6486002)(478600001)(2616005)(4326008)(36756003)(41300700001)(2906002)(31696002)(86362001)(6506007)(38100700002)(85182001)(82960400001)(53546011)(6512007)(83380400001)(5660300002)(26005)(122000001)(38070700009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWRLMVFEL3Nnc1FSKzNUY3FaMXJpVW1jYTRKdHRrOEgrN1l4VTZReUVTc0pn?=
 =?utf-8?B?TE1sM0RXaVY0R1Vxb0g2WjRGTXFiV09mcngxNEpsdTdSZTdyb2pFMTRwSHcv?=
 =?utf-8?B?Znh6UmhncE1UajFCQzh5T2x4TlVrMVdzcE52V0dqUU5ITHovQUpYMnExMlNS?=
 =?utf-8?B?SUlmVUlTemYzMkE0b1JuenhSQllTZWpoV3NJemdXeGljWklRbzdBc1JOcWlB?=
 =?utf-8?B?aGtTSDlrOEdMMzRtMHBvT3EyMFc3Z3RPRTZZanZZS1ltUk8veFBKY1FhQnkx?=
 =?utf-8?B?TG1Yd3ZLbHc2TUIvQ0ZSc1NLNFZodUF1TGE1aUFzK2NFYmZBYUtyUkVpTm5I?=
 =?utf-8?B?eDRjQjhPK0Z0cGF5SUlwVFBIc3ROV3JZOXJFM3JURGpkVnJ6WXVqcUNlMDQ5?=
 =?utf-8?B?N1ZsQUhoUGFQZWJyQmRHbnQzTEx2L3RFZVVaNUxiUGxaNGJxa0E1bVVmQmRP?=
 =?utf-8?B?cTBNS0VuYnBNM01pdjRPNDdtNDIzNU9pUy9IaUw0NzA2NU5oUHhxNktqVjE4?=
 =?utf-8?B?SEJROUpHeEFFeFZyUHAvemk3aWZTS2JveXI3N1o4M05rWVU1N0FIQ3V0ei9r?=
 =?utf-8?B?VFZMbnVFZXJiVGxYUjd5N3UrY0tMang0ZTJyY2MvRG53N2szTVhKK2wveThh?=
 =?utf-8?B?RUpKNEFvTWx1WVYvQ3lUdDZVcEY5L1ZBUWNVcnplMnRSSmZwOEZINml0cGNn?=
 =?utf-8?B?emVaMGdndXNRcjhlQUJtSEYxd01KSnZTWUxiLzZPbGZyanhlZnFPa2F2SkJZ?=
 =?utf-8?B?dUM4YVhGM0xSVDVNZUV4ZWUyN093M3RySU8zZlVLOEt3SjJVL2J4cDhRYUZI?=
 =?utf-8?B?ZlpSNnNWTUFueDMxcE1NOUZkY1JFU1FWYTJtL2dhbGNxQWtNYlpCa1g4SUU1?=
 =?utf-8?B?bXIzRHRDMC9oODdGaUJNSFdEUHpjdGFSdVJoMllNbkJzVllVWTY1dVgvQjQy?=
 =?utf-8?B?UkswU2Y4S21qZWIwQ3UySzQ5Z01pUFdxaW5WZ2hBVy9ZaXRIbDVoK3J0SWxK?=
 =?utf-8?B?T0JQWUs0alE2cDFQYWJnMWhFc2J2dlQ2VXVPanRPaTI3SFA3R0NjZk94dlpX?=
 =?utf-8?B?NVUzRlJvbGJsdTkzY1Y5MDlPejU5VEpGbXRoRlhHMUlHS2Q1TjBMS05Cazdw?=
 =?utf-8?B?QVZmTWs5WGRIdDVmMm9PUlI3YnpxZGtHM1dWUTBxRGRjU3RVMjVUVUtnTlNI?=
 =?utf-8?B?and4SHI0N1k5THRsK2VMWU55RHBHYkphVktRVE5QZ3hmd25uWUhNVi9SajM2?=
 =?utf-8?B?Ui9PYWFZNksrbmRpblhqcEtzVE15cXA2clJNNlB4VndrMTR0blRyaVpaMEZV?=
 =?utf-8?B?VktxcDRoNTgyQWF6VUwyL05wQWhNNnYrYWZ3UXpheHRaNExGTkxZYmo0eFJO?=
 =?utf-8?B?WHB1MWhvWG5qVm9XbFdLekp2ZzN3VHY0cEVtVnJRNWkyVlZxbFFNc3k0Vk81?=
 =?utf-8?B?NzJRbkFmVkxGV3lwci9Jcm52RVVoUVltRVN0eHZrYWkxWTBKaWw3bXJqL3c3?=
 =?utf-8?B?Q2had2tBOVFHUlpUTm9BK2gweDBLdE03RitQblJOVFRGZUlHTG95aXZvNDB1?=
 =?utf-8?B?MUhLSWxtRkVkVTBGVjFwRjdnVUNFTXI0dEZyWW83VHFSNDArUld3K1V3b2p1?=
 =?utf-8?B?NEh3OXZpOVVaMnhtQ2IyTHdyOVVYZXhpZ3JFSmN4akgxR0c4eEVtcEtXWGRz?=
 =?utf-8?B?bGdiTEpTNFpLTjF3WDBLdUF0K3RQRE9vZDhBVDhYMnRPLzBLTVdrUFdJcTZS?=
 =?utf-8?B?TXVZNE1kMUpLY1VUbkpQMTU5Qm9pTE5TSGd1RFV4cDB5UzNUakhjZzZRUDRk?=
 =?utf-8?B?aFBGUDhucCtTakJGU1NEOFhNdGlKbE85WE82UGNtMnZSQ1RRVUtzWTdVTXdn?=
 =?utf-8?B?NUNhaEhmUGJtMnRpN1F4azdKaGNVbVhzenE5SjFVZHNvVlYzYXdSbVBFRFhz?=
 =?utf-8?B?bGp2RnNrdnZQRUJyd0Z1NTMwK2F2UmZ5T0tFN3ErWDIwbnRheHBnSC83VEJU?=
 =?utf-8?B?UGt1MUErWERNT2hNVUVPSHlmZVhnWlVSUU9FazVqeUhBZHBmUDJ2WWxUNVNT?=
 =?utf-8?B?anB2SG0wWlQyQVFjdzhWbXl4Vnd3NDFWTUFFUlF6K1VyMHlHK1FNNFZ5QWJo?=
 =?utf-8?B?ZEZsYUFhZitBUWNMT25XSW91LzZDUUllT3BzMXB6dUcwZGNZRlBHUldlYWJU?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD540C57B63FD449932619692989F818@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cHJWd084ZUYvNU96d2pzWkRXRnlQeDAxWG1MZXBiMWVWTHAwKysvQ0F2WnU3?=
 =?utf-8?B?N0l4ZXdUTTBJNkc1ay9mQUxRMEdLVHBYYStqdlQ2TitRVkowN0pLTVY4d1Y3?=
 =?utf-8?B?OTRmVXllSWZNRFV3UVVvd1pnTEpnRnVaS1JhTmthNGhHNmRYMUlqTnQ1TWtp?=
 =?utf-8?B?ZllPVXZFK0hMVGxlSlF0ODlGa0tPNFE4ZnpGT0lVY0lBdWswV0poRTFpRXVq?=
 =?utf-8?B?V1B5Tnk5YjJISFRDYk1aeWNwb01ncTlhUTZJMlJxSWNKYzBzcDdsN2JRMGlQ?=
 =?utf-8?B?WUxuUlJIbDZXSTJlWlJJdkxrd25hbWozYW42S3U5S0JMRmJWR0FkdFM5L1FT?=
 =?utf-8?B?Q3p5SEpWalFWUktrT21wMVRXbUpHVkdpMTNHT2o5Q1JneHlhVlZBRFYrZ1Rr?=
 =?utf-8?B?VFVOTEdpZWtMcEk5ekpLMzVJQTBuY3hPeis2R0pKT2F4a0gyb1VkRDFxeWRr?=
 =?utf-8?B?azJmbzdxakJqcHUvVEMyRC9DRGNNSEFxN21mRDVXMDdRcWpFcDhUbHF4OFhF?=
 =?utf-8?B?L2JxaUl6dEJkSTlqM2lTV1NvQlFnOGI2WTd0OXhSNzBUT3U0WHRpWlRLNkFS?=
 =?utf-8?B?NGZMNjkxQm1DL2pzUlJPWlg3RzFUV1lvT245T3NKbVltcThkeFF6bDVUU0tr?=
 =?utf-8?B?QUxjUUZiaEFiM0RqK3ZYSXNKSVAxb0c4cUVNVmZDOFlJMzI4NzdzMXI4NmxT?=
 =?utf-8?B?NFpObk03Rnk4SFAvVFNnWGRIZUI1citoVlpkcnYyU0dGSFpZbzJMUGVmSjJV?=
 =?utf-8?B?YUVreWxwSnQzVk1nWHI2cU0rQnBySTNHVk1XNGFGYVlmT2c0RUx2SFJJWFN6?=
 =?utf-8?B?L2VnRTRxeWlLb3ZDTXlMMVNGbi9CT0tTaFFRdU1rN0tDNXdnY09qK2xONEhp?=
 =?utf-8?B?ZkhZYmV2RFVwdVRTZTZKSG00dkJKL1JqZDArb0dlNWZhdDJqK3ErM2xTU1lP?=
 =?utf-8?B?L0FzQm1lQTBYWFNianN3RmlqR29oWTdPdHBRS0l4aW41RkxpbWU0YVR3WHpW?=
 =?utf-8?B?ZkpGWG1uT2J2eVB3azhBcU1ianovdVZFWm1RZU84QXRHQmhqWVVMZ2o4YWJC?=
 =?utf-8?B?Ni80TEVUUjIxUWJ4TVAzdldmV2xvbi9GOUFrZHhaSGNoWjNmWWxQY2NGNXhG?=
 =?utf-8?B?UHVuaVg0cm5iNlpybExXc241Z1FVRGI3U3F6OXl2SkRWclFCUXRlN09EUnBn?=
 =?utf-8?B?ZkQvSDd1djRueDZzeWZGMHJqRVVtRGtzZmdiME5JRExCaWRhVWZVRG53dnc2?=
 =?utf-8?Q?IBWN91GWeh0bWFS?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1b9aa-af01-4726-df83-08dbd11f3a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 03:47:05.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3s4Z998mqZk7TRdax7B3QAF+o3x7opes7iYQveIqiASEHaUKFdIhh9x6PLrEJcuMUBpKGvSnLmeUmKGA3v0UTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11185
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Q0MgQmFydA0KDQpPbiAxMy8xMC8yMDIzIDIwOjAxLCBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3Up
IHdyb3RlOg0KPiBPbiBGcmksIE9jdCAxMywgMjAyMyAxMDoxOCBBTSBaaHUgWWFuanVuIHdyb3Rl
Og0KPj4gRnJvbTogWmh1IFlhbmp1bjx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4+DQo+PiBUaGUg
cGFnZV9zaXplIG9mIG1yIGlzIHNldCBpbiBpbmZpbmliYW5kIGNvcmUgb3JpZ2luYWxseS4gSW4g
dGhlIGNvbW1pdA0KPj4gMzI1YTdlYjg1MTk5ICgiUkRNQS9yeGU6IENsZWFudXAgcGFnZSB2YXJp
YWJsZXMgaW4gcnhlX21yLmMiKSwgdGhlDQo+PiBwYWdlX3NpemUgaXMgYWxzbyBzZXQuIFNvbWV0
aW1lIHRoaXMgd2lsbCBjYXVzZSBjb25mbGljdC4NCj4gSSBhcHByZWNpYXRlIHlvdXIgcHJvbXB0
IGFjdGlvbiwgYnV0IEkgZG8gbm90IHRoaW5rIHRoaXMgY29tbWl0IGRlYWxzIHdpdGgNCj4gdGhl
IHJvb3QgY2F1c2UuIEkgYWdyZWUgdGhhdCB0aGUgcHJvYmxlbSBsaWVzIGluIHJ4ZSBkcml2ZXIs
IGJ1dCB3aGF0IGlzIHdyb25nDQo+IHdpdGggYXNzaWduaW5nIGFjdHVhbCBwYWdlIHNpemUgdG8g
aWJtci5wYWdlX3NpemU/DQo+IA0KPiBJTU8sIHRoZSBwcm9ibGVtIGNvbWVzIGZyb20gdGhlIGRl
dmljZSBhdHRyaWJ1dGUgb2YgcnhlIGRyaXZlciwgd2hpY2ggaXMgdXNlZA0KPiBpbiB1bHAvc3Jw
IGxheWVyIHRvIGNhbGN1bGF0ZSB0aGUgcGFnZV9zaXplLg0KPiA9PT09PQ0KPiBzdGF0aWMgaW50
IHNycF9hZGRfb25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkNCj4gew0KPiAgICAgICAgICBz
dHJ1Y3Qgc3JwX2RldmljZSAqc3JwX2RldjsNCj4gICAgICAgICAgc3RydWN0IGliX2RldmljZV9h
dHRyICphdHRyID0gJmRldmljZS0+YXR0cnM7DQo+IDwuLi4+DQo+ICAgICAgICAgIC8qDQo+ICAg
ICAgICAgICAqIFVzZSB0aGUgc21hbGxlc3QgcGFnZSBzaXplIHN1cHBvcnRlZCBieSB0aGUgSENB
LCBkb3duIHRvIGENCj4gICAgICAgICAgICogbWluaW11bSBvZiA0MDk2IGJ5dGVzLiBXZSdyZSB1
bmxpa2VseSB0byBidWlsZCBsYXJnZSBzZ2xpc3RzDQo+ICAgICAgICAgICAqIG91dCBvZiBzbWFs
bGVyIGVudHJpZXMuDQo+ICAgICAgICAgICAqLw0KPiAgICAgICAgICBtcl9wYWdlX3NoaWZ0ICAg
ICAgICAgICA9IG1heCgxMiwgZmZzKGF0dHItPnBhZ2Vfc2l6ZV9jYXApIC0gMSk7DQoNCg0KWW91
IGxpZ2h0IG1lIHVwLg0KUlhFIHByb3ZpZGVzIGF0dHIucGFnZV9zaXplX2NhcChSWEVfUEFHRV9T
SVpFX0NBUCkgd2hpY2ggbWVhbnMgaXQgY2FuIHN1cHBvcnQgNEstMkcgcGFnZSBzaXplDQoNCnNv
IGkgdGhpbmsgbW9yZSBhY2N1cmF0ZSBsb2dpYyBzaG91bGQgYmU6DQoNCmlmIChkZXZpY2Ugc3Vw
cG9ydHMgUEFHRV9TSVpFKQ0KICAgIHVzZSBQQUdFX1NJWkUNCmVsc2UgaWYgKGRldmljZSBzdXBw
b3J0IDQwOTYgcGFnZV9zaXplKSAgLy8gZmFsbGJhY2sgdG8gNDA5Ng0KICAgIHVzZSA0MDk2IGV0
Yy4uLg0KZWxzZQ0KICAgIC4uLg0KDQoNCg0KDQo+ICAgICAgICAgIHNycF9kZXYtPm1yX3BhZ2Vf
c2l6ZSAgID0gMSA8PCBtcl9wYWdlX3NoaWZ0Ow0KPiA9PT09PQ0KPiBPbiBpbml0aWFsaXphdGlv
biBvZiBzcnAgZHJpdmVyLCBtcl9wYWdlX3NpemUgaXMgY2FsY3VsYXRlZCBoZXJlLg0KPiBOb3Rl
IHRoYXQgdGhlIGRldmljZSBhdHRyaWJ1dGUgaXMgdXNlZCB0byBjYWxjdWxhdGUgdGhlIHZhbHVl
IG9mIHBhZ2Ugc2hpZnQNCj4gd2hlbiB0aGUgZGV2aWNlIGlzIHRyeWluZyB0byB1c2UgYSBwYWdl
IHNpemUgbGFyZ2VyIHRoYW4gNDA5Ni4gU2luY2UgWWkgc3BlY2lmaWVkDQo+IENPTkZJR19BUk02
NF82NEtfUEFHRVMsIHRoZSBzeXN0ZW0gbmF0dXJhbGx5IG1ldCB0aGUgY29uZGl0aW9uLg==
