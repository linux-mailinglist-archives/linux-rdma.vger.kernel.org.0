Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C67C864C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjJMNBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJMNBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 09:01:24 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CFBE
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697202083; x=1728738083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZfCoz+PrnLI50deVar/WOCCM/qS/VVRRS4IUstF5aXI=;
  b=NXfmkkHZXMkAzqcoRQSNTey1FsKPtDFU4PCmRQUEc+2tNi3bpJjVcHRe
   v8WA4xpUOKC3U7TmUVZ2D0282NfiTQnoioRL9hTBGP4HR9y6yQ4LSgn/T
   xPmPg26Bu/2ixcWURkh6pfYTMH7FGCi1q6yeDcyN2YCLxkCH/Fp23irAr
   AnwbKOV29OrnMJkFlq7dBx5Y3tcyFyMuIYtVbe3/wr+uTkmVGbs3U/pd6
   iZbbaQZQz6dSbCdJ1bYhaJFhY2PAc3AFSayAwjBHRksP6oCwJYOfpMT6P
   1jD8tcXLDcJKyT/sOPRF3KCa10ePSYZ5hY5Ry0lJVOHcVbUgfH/30I9Ki
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="99203142"
X-IronPort-AV: E=Sophos;i="6.03,222,1694703600"; 
   d="scan'208";a="99203142"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 22:01:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1ypNpbp+oHEavodkSTeR3ZHtB77yjs/ueGj4SVnllYB0cF0Woes0FeHJXmA56mnUa1bjzDf291z+0UEzmjFLdC6TiVKdtyxRwMgHuElGSq+fz8dYWLMsUBkLcGS8odRj1KEKeL/f0A7IIkkhw+NxkUy3hukGodPbbGmuH3yDm+klUk42mkvF1ZipxqI2GpKrXD5l7SJSxLcClXoTfLhckF8M433DKog7xhrHmCG7mmyJMopYw/9yd7BOoE7l5lNULbyoXFdKAWSk2URCsJQ4iWRgMxHgzlnEDA8HfyOXx5CD4tLGeCcYptnsAsFhcNQIlU2CDjh79d7ggFbp/AIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfCoz+PrnLI50deVar/WOCCM/qS/VVRRS4IUstF5aXI=;
 b=XSSx9JREvx6t6ALXltoleUO4qqE4pWo3lmx34x/ci9zLs463HQ+7b5QUMe1tRsDyYSQeSuHLD3/uryk/DPTDQRRfAA2Dba2YI8whsfU8vOTC9HWplmarMDAh9FYPXb6nn48sMsfu4Z7DxpNI1K5ortmLJ8py/+FpjqzSSKw58qnuAtv7ui6CBBacHRBZPQakDSpmr65RltBVWxSVxAZGu53RQ9M9J7o0BuAj1o9UYp6RarXcPTuyMy/zsRfiODplSWf8bNlbQi7gQaTYzhd1Ein8U9Jd+jHbfGmjoOVaA1EPIS8uJS2mLiJOY+/WlVlRFF8Z7zezNljDNJGgs1/z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB9691.jpnprd01.prod.outlook.com (2603:1096:604:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 13:01:15 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 13:01:15 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL92/TSgxYyx0mXQnQUi6BiibBHQm7ggABkQoCAAABxoA==
Date:   Fri, 13 Oct 2023 13:01:15 +0000
Message-ID: <OS3PR01MB986557755D5DE20BB7BD60ECE5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
 <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <6f155aa3-8e75-40c5-9686-cad9f9ac0d81@linux.dev>
In-Reply-To: <6f155aa3-8e75-40c5-9686-cad9f9ac0d81@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTU2YmIzYmMtMjdkMy00MjMxLWEzODktZDllMmI0MTUx?=
 =?utf-8?B?OTlhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0xMC0xM1QxMjozMDoxM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB9691:EE_
x-ms-office365-filtering-correlation-id: fdd78949-e911-4786-0fc8-08dbcbec7bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZ+AP/eTvQK/EhbBNu4/Ky5++ANu/0729z6T0zqICiIQjyxEGTmB2eE5cwzScO+XQT1I1jXMA+5lE6s9jsHLp4IsJIsaklgLrkXzUSp5nHvlUc1cVuxPAsbM7k1oFtU/nT2yLponnl+kMZK0bmVXp+mPs6QoXmbVIP+lwayN9lIFwmIS8SN43lzk3A/jqa0wzxv6X3jDidqG/Gj5L/JK+3MsCAy+p4pDonz3NrtZ9dGEeZEUAkL6DDw17bFyK5RrcUNMtw4+/cL5GvALLJ2QWzf+/ccmqySYlfFEaNcW6Oz69DglFhFGhUI8vLqu2zO+uO025iy/XEztzm8eIIbIMGd7fz6uD4TSo3hjVIvRmJYVh77gvJKwxfCkh+U4OkltFOPEnMh4x0RXRDKIVlD9gmucLAwoDtor4nxGWz68Nc0ZSyYvKl8xeg4hRjZgyeSmy4tDn19jfmpdQbk17wvOehcn36HT+wtVuNURQmvYgfex5JT83WJj4nYOkOv7Ys3QxQleH/PEahqG3Vlr/Qfeex6iFvBtiJ75/zOKfiOc5Ub+/jdWi5sBZ8Dl1hOrn09HWLbUlj50FkwIZl6vzt5S9Z6Mhioo9znbUwVSV4CUQsVI6hX7dGGX4LYuEIGZvnz7XJ/yHY/GjusfwlVtDZb2/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(1590799021)(451199024)(64100799003)(6506007)(7696005)(53546011)(55016003)(5660300002)(52536014)(1580799018)(71200400001)(66899024)(83380400001)(26005)(33656002)(2906002)(85182001)(38100700002)(122000001)(86362001)(82960400001)(38070700005)(9686003)(110136005)(64756008)(66446008)(54906003)(66556008)(66946007)(66476007)(76116006)(316002)(41300700001)(478600001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2ZhMnYvY1FWVG1tTDZnbDQ2T0ZVS2xTT3dXRmNsWVdabGErczlTYUIwYStI?=
 =?utf-8?B?cU0vN21XUUhQQjdkalNDQ0hNNDhrc09HKytBNGx5UzBYVktBRXR3Q1FMUDI5?=
 =?utf-8?B?RURRZWFBQzJIeldmNlNvTkJZWXJ3MVllanZmeWVqR3RQTU9RTm92bTM1cU15?=
 =?utf-8?B?U2NnbnRkRmpJTnR3aTlHc2Z6UVcxYTI2U3pzTGg4SjNwYzE2NFByMys5OVJD?=
 =?utf-8?B?eXJuTzFqaEJKQXcwRENkaVQ4L1JLbTdpUGZyYWVvUnVGdTIzUTBCa0tvRVAy?=
 =?utf-8?B?VkpsOG84SVBOYXo3WURKVVFkTmNCbWIwL09JZVBCZDVXVWpWaVVRY1AyVVBY?=
 =?utf-8?B?c25pU0VieisxVGhOQU1naXhRRDEwYS9yemNHSEEvQ0FuLy9maTBsbmg3Ymo0?=
 =?utf-8?B?Nm0xNGRxYXFQTEN2ZmJub3pJOGhkR2VNaEVMUXdvbXZ5Y2hSMEJydFA2SWky?=
 =?utf-8?B?eEtrTjl2TnAxazc4dERLMkRkUEczS3kvbW9NMUZGbVk2c242WXZMMGh6enIr?=
 =?utf-8?B?VjFOOTJIWnd4YWlQQnQvbFBHb2o5ODcyZzRlL2dDOERPMTdxcWJEQ2ZJelo3?=
 =?utf-8?B?OFRmMFhLemc1dkoxOGxmcnRIMm0wVGVMaEhYSWdnOERRSC90SG1mOFZVdUI0?=
 =?utf-8?B?UnAzVUNSM2lYOXNseW1yN0lNR0xzVTFDeTFlOE9VNXpTY2FUOVI0dHoyb0tT?=
 =?utf-8?B?L0RxN1lzQVdUcEZ1N1l4TGhQeDFKbnZsemxGOFhaa3c4RmhjeGE0ZkNmWDdB?=
 =?utf-8?B?ZC9LYXdVeSt1NDBrMjF1Rzd6ZDdseGxBd3VnV3A0Y0ZTcTZYU0kzRngrdGx5?=
 =?utf-8?B?cmNINVdnSWlGN1VWcHE2S05FZS9KUEF4eDZUU0lqT1lhMDZBUDNaVDBqZkpO?=
 =?utf-8?B?UnFuOUpzQ0N0OEdXMytablVJV2Y3cnNqQ0M0NlN6MDhoaTFlSTBNWnRLS0Ix?=
 =?utf-8?B?SHNOQkZQQXlmYjRPNlZZRzg5ZkhxTkRnVHlOLzlSbitwTEpNMklScWtJNzZ0?=
 =?utf-8?B?NmZObDhTZmJWUEZWY2JvK1p5Zk1vM0pXV1NPM3kxZnJFenh2ZTdYUWhTcm1h?=
 =?utf-8?B?bzE4TEUxbUpUMXRlWURHZXJpNEdjeFBQdlc1NmJjaVJkejFidWFLOVJUOUhY?=
 =?utf-8?B?djhwd21rakY3VDhpT0lwZlMreUp4a3ZoTDlUNnZQUmUrL0tuVDlSQjFWeVpW?=
 =?utf-8?B?Vm53a0VtdU9KR3ZoU0xOSjdvT3IzNWl6dkh5dTQwUjRXMXFNcjZmQzkvY1A2?=
 =?utf-8?B?M0ZzeW1ydFZhUWxFL0liOFE2d3VQNUZPMFp4c2hPUjhFVzhPUzZTNXJWYWNz?=
 =?utf-8?B?KzZqeDZYTTZJK3FYTkRtaUpYTmVXd0tRQXI2ZFdMZHR6dU1MNEw1blAveFNM?=
 =?utf-8?B?cXk1bDl4RktuRXkwaVFRSkRXTkFuL01ROGUwK3Y5MmorVWFaYS9GaXlZckV4?=
 =?utf-8?B?cTNySWNrTDRFTkNHNjRKSE1qRVBwQUJLVzVCTEUwYlhOY09JWE1mSkhITmVp?=
 =?utf-8?B?ejJSeXBPY3dDcG9UM0h2ZWZ6SDh0V0hzbUN5VlVEaGFhaTNocHZ1Y0RNS2ZD?=
 =?utf-8?B?aWxPZlhLRWk4RjNIa0cyZUxBd0F1SWg3cGNDK25yUVBKVVVLeVNLa2luQVNL?=
 =?utf-8?B?SGNTdkk5cjZrd2paNnpLZTZEWGFmeTFpSFZoY21lOUxGU3ZQUCt6QWpnUWdB?=
 =?utf-8?B?VmpMN3lZTGJUaVowZUErL2N6aE1jZ0hiVEt6MDEzOHdRcTJGVHpCN0JMMWpu?=
 =?utf-8?B?N1cyT2toaHI3amVJV1UwemVPNGVadlRvR0d4cVZGd0srVmxtV3pRMEZ5c1Bs?=
 =?utf-8?B?ZmtGY2VZN0Y2NFhyZ1JuY0lISjVqVGVWeHJUUHF1S1BZdExkZUd0L013Y1Qr?=
 =?utf-8?B?NDdCRlpSU0haZ3pDMTBHNTdlcGZyU3k1TEh2QjRRdVcwNVRvYWNtWVpaUkdw?=
 =?utf-8?B?V0N5clk2b0J6cDhUeVk1aTdZYTEyaElCT292ejJhQkJDTmlETTc3Y05VZHFL?=
 =?utf-8?B?aERXaUVaME5pbHRNMC9vY0cwc2Z2Nml1UEp0TVBDZnNlVExuTmFtN0NjWTRT?=
 =?utf-8?B?b0VMdkl2ai92b25jRUtyajNwUmRxOHF5UzBMWnh5aWo4R24rcXRORm1BVC9i?=
 =?utf-8?B?NzJyVWkwQ2xwdXhiTkdUSjAzMTk2cXM1OVNxV0YyUFYwZlFad0hoajB4TjY5?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MWFBVmluRmE1WlpHVDArMGdvaDFPTVhseXZRampxN1ZzTlAyckgraUkvNFFP?=
 =?utf-8?B?L3RRY2dubGRobmdMV29Id2lWY0w1cmxmRFRqdWtWVjJlb01MZDJoYWJiWmdK?=
 =?utf-8?B?SDNsUVJHTi9GT1VuejBiUTNiVVg3RFF5NTVuTE56NnUvY3Y0SFFDZk9SOTZ0?=
 =?utf-8?B?VHZGS1Q0R3k3Wi9DVENBT0VGc1pIbVJxaUVVaEtYbHFUQk52cUplMmNjcGRV?=
 =?utf-8?B?QndlSXEyaGJDNkVZYmg2VUFLTU03QngxNnY5OXkwSE1FdklNZFhNRzhROG5X?=
 =?utf-8?B?NGQ1V2p2WlVBcy9BajFuV3d3R1lLa1NIMUlZTHhBWDhGRzQvbEJYVUlEVDRh?=
 =?utf-8?B?R1FpMDhzV25USUFNQ0RNNXRhVkd3eWVhYTIrbFhqd2hRTW1RQzVCenh4UWFp?=
 =?utf-8?B?WjNBY2xvdFc1YzBWNWFacWRsWlZhTHVuYkVFUUdFTEdLNTVRUG9DK3ZrNjdh?=
 =?utf-8?B?Q21VU0swazdhd3gvOXc0UUZxT1c3aWk2ZlAxVGl4eCtaempORVF5bFVYVVM0?=
 =?utf-8?B?WUpLeERuTFhHeHRiSzdjSW1hWEY0VjhjVktMckp1UmpPbnJTcEtGKzBxTUo3?=
 =?utf-8?B?eGx2bGhUUkNYTVRKSUlkZ0pkOU94enRUYW1mQUdQUDFoWWxUc0thL1VLNUg5?=
 =?utf-8?B?YjBaL3RONjBmOVZ3U2JBR3hIcDFacjB5TWdPK1ZmckhuNjJ4YWJncFpFNEh5?=
 =?utf-8?B?MFNvWjNDVXVJTms1UjFMR2JpUHVJVy9pakRDbzB3TDB4NkNrbVh4dTlaMzhz?=
 =?utf-8?B?a2hpMkNUOUM1dGxWK01Xb0xvUldxZnRMWWhFVTBja1NvYmcvbWJSM01MdDRs?=
 =?utf-8?B?c1kxVUI0OVdTSDd6SUkwVmdlVjYwQ0JpTGs1ajRza1dIUjI3NkZBR2Z5cHVF?=
 =?utf-8?B?ODZNRnA4VzdZaHJlZWVJbm1najZSbFc4ai90US9XeDFhTkdGT2FZencvc05w?=
 =?utf-8?B?eXd4Y2ZjbzFFdVlZT0tMRUVlelNzZUZJbmJLbkRPc3ZSaWJROWcwVWdiTng5?=
 =?utf-8?B?VCtXTUV5RHRZYkowN1h1RnVIRFFsem9hS2RtQzRUcmExaVNaOVBVMEJUOFRB?=
 =?utf-8?B?NC9wK0o0ZWxFVlBTOW9jMi85SnBCTkQ1dkZiL1hkR1R3T2hPZ1UvbS9HOTB6?=
 =?utf-8?B?ejZWNDdnemp3NStYWURaWVM4MnhaR0x5SzBBZkFmM1N4bHBvdUhJRmM1aWhY?=
 =?utf-8?B?eXpzZGdxaXJkVVZMbmtkeXlYUUEzOGhOem9rS2ZydVRkUkVmdERLeStILytn?=
 =?utf-8?Q?bqZ5ay2bDIK6epg?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd78949-e911-4786-0fc8-08dbcbec7bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 13:01:15.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +J3k8hCKVkkhb8umBQPmd0anN9ND432T1E1SeQCuYJxf9ahQH9l5A1mDBPhn+7AGqhP0wzPK3cyXvwrEMgCkEygU2He989pVCl1MoBecHhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9691
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpZGF5LCBPY3RvYmVyIDEzLCAyMDIzIDk6MjkgUE0gWmh1IFlhbmp1bjoNCj4g5ZyoIDIw
MjMvMTAvMTMgMjA6MDEsIERhaXN1a2UgTWF0c3VkYSAoRnVqaXRzdSkg5YaZ6YGTOg0KPiA+IE9u
IEZyaSwgT2N0IDEzLCAyMDIzIDEwOjE4IEFNIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4+IEZyb206
IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiA+Pg0KPiA+PiBUaGUgcGFnZV9z
aXplIG9mIG1yIGlzIHNldCBpbiBpbmZpbmliYW5kIGNvcmUgb3JpZ2luYWxseS4gSW4gdGhlIGNv
bW1pdA0KPiA+PiAzMjVhN2ViODUxOTkgKCJSRE1BL3J4ZTogQ2xlYW51cCBwYWdlIHZhcmlhYmxl
cyBpbiByeGVfbXIuYyIpLCB0aGUNCj4gPj4gcGFnZV9zaXplIGlzIGFsc28gc2V0LiBTb21ldGlt
ZSB0aGlzIHdpbGwgY2F1c2UgY29uZmxpY3QuDQo+ID4NCj4gPiBJIGFwcHJlY2lhdGUgeW91ciBw
cm9tcHQgYWN0aW9uLCBidXQgSSBkbyBub3QgdGhpbmsgdGhpcyBjb21taXQgZGVhbHMgd2l0aA0K
PiA+IHRoZSByb290IGNhdXNlLiBJIGFncmVlIHRoYXQgdGhlIHByb2JsZW0gbGllcyBpbiByeGUg
ZHJpdmVyLCBidXQgd2hhdCBpcyB3cm9uZw0KPiA+IHdpdGggYXNzaWduaW5nIGFjdHVhbCBwYWdl
IHNpemUgdG8gaWJtci5wYWdlX3NpemU/DQo+IA0KPiBQbGVhc2UgY2hlY2sgdGhlIHNvdXJjZSBj
b2RlLiBpYm1yLnBhZ2Vfc2l6ZSBpcyBhc3NpZ25lZCBpbg0KPiBpbmZpbmliYW5kL2NvcmUuIEFu
ZCB0aGVuIGl0IGlzIGFzc2lnbmVkIGluIHJ4ZS4NCj4gV2hlbiB0aGUgMiBhcmUgZGlmZmVyZW50
LCB0aGUgcHJvYmxlbSB3aWxsIG9jY3VyLg0KDQpJbiB0aGUgZmlyc3QgcGxhY2UsIHRoZSB0d28g
bXVzdCBhbHdheXMgYmUgZXF1YWwuDQpJcyB0aGVyZSBhbnkgc2l0dWF0aW9uIHRoZXJlIGFyZSB0
d28gZGlmZmVyZW50IHBhZ2Ugc2l6ZXMgZm9yIGEgTVI/DQpJIHRoaW5rIEkgaGF2ZSBleHBsYWlu
ZWQgdGhlIHZhbHVlIGFzc2lnbmVkIGluIHRoZSBjb3JlIGxheWVyIGlzIHdyb25nDQp3aGVuIHRo
ZSBQQUdFX1NJWkUgaXMgYmlnZ2VyIHRoYW4gNGssIGFuZCB0aGF0IGlzIHdoeSB0aGV5IGFyZSBp
bmNvbnNpc3RlbnQuDQoNCkFzIEkgaGF2ZSBubyBlbnZpcm9ubWVudCB0byB0ZXN0IHRoZSBrZXJu
ZWwgcGFuaWMsIGl0IHJlbWFpbnMgc3BlY3VsYXRpdmUsDQpidXQgSSBoYXZlIHByb3ZpZGVkIGVu
b3VnaCBpbmZvcm1hdGlvbiBmb3IgZXZlcnlvbmUgdG8gcmVidXQgbXkgYXJndW1lbnQuDQpJdCBp
cyBwb3NzaWJsZSBJIGFtIHdyb25nLiBJIGhvcGUgc29tZW9uZSB3aWxsIHRlbGwgbWUgc3BlY2lm
aWNhbGx5IHdoZXJlDQpteSBndWVzcyBpcyB3cm9uZywgb3IgWWkgd291bGQga2luZGx5IHRha2Ug
dGhlIHRyb3VibGUgdG8gdmVyaWZ5IGl0Lg0KDQpUaGFua3MsDQpEYWlzdWtlIE1hdHN1ZGENCg0K
PiBQbGVhc2UgYWRkIGxvZ3MgdG8gaW5maW5pYmFuZC9jb3JlIGFuZCByeGUgdG8gY2hlY2sgdGhl
bS4NCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+ID4NCj4gPiBJTU8sIHRoZSBwcm9ibGVtIGNvbWVz
IGZyb20gdGhlIGRldmljZSBhdHRyaWJ1dGUgb2YgcnhlIGRyaXZlciwgd2hpY2ggaXMgdXNlZA0K
PiA+IGluIHVscC9zcnAgbGF5ZXIgdG8gY2FsY3VsYXRlIHRoZSBwYWdlX3NpemUuDQo+ID4gPT09
PT0NCj4gPiBzdGF0aWMgaW50IHNycF9hZGRfb25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkN
Cj4gPiB7DQo+ID4gICAgICAgICAgc3RydWN0IHNycF9kZXZpY2UgKnNycF9kZXY7DQo+ID4gICAg
ICAgICAgc3RydWN0IGliX2RldmljZV9hdHRyICphdHRyID0gJmRldmljZS0+YXR0cnM7DQo+ID4g
PC4uLj4NCj4gPiAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAqIFVzZSB0aGUgc21hbGxlc3Qg
cGFnZSBzaXplIHN1cHBvcnRlZCBieSB0aGUgSENBLCBkb3duIHRvIGENCj4gPiAgICAgICAgICAg
KiBtaW5pbXVtIG9mIDQwOTYgYnl0ZXMuIFdlJ3JlIHVubGlrZWx5IHRvIGJ1aWxkIGxhcmdlIHNn
bGlzdHMNCj4gPiAgICAgICAgICAgKiBvdXQgb2Ygc21hbGxlciBlbnRyaWVzLg0KPiA+ICAgICAg
ICAgICAqLw0KPiA+ICAgICAgICAgIG1yX3BhZ2Vfc2hpZnQgICAgICAgICAgID0gbWF4KDEyLCBm
ZnMoYXR0ci0+cGFnZV9zaXplX2NhcCkgLSAxKTsNCj4gPiAgICAgICAgICBzcnBfZGV2LT5tcl9w
YWdlX3NpemUgICA9IDEgPDwgbXJfcGFnZV9zaGlmdDsNCj4gPiA9PT09PQ0KPiA+IE9uIGluaXRp
YWxpemF0aW9uIG9mIHNycCBkcml2ZXIsIG1yX3BhZ2Vfc2l6ZSBpcyBjYWxjdWxhdGVkIGhlcmUu
DQo+ID4gTm90ZSB0aGF0IHRoZSBkZXZpY2UgYXR0cmlidXRlIGlzIHVzZWQgdG8gY2FsY3VsYXRl
IHRoZSB2YWx1ZSBvZiBwYWdlIHNoaWZ0DQo+ID4gd2hlbiB0aGUgZGV2aWNlIGlzIHRyeWluZyB0
byB1c2UgYSBwYWdlIHNpemUgbGFyZ2VyIHRoYW4gNDA5Ni4gU2luY2UgWWkgc3BlY2lmaWVkDQo+
ID4gQ09ORklHX0FSTTY0XzY0S19QQUdFUywgdGhlIHN5c3RlbSBuYXR1cmFsbHkgbWV0IHRoZSBj
b25kaXRpb24uDQo+ID4NCj4gPiA9PT09PQ0KPiA+IHN0YXRpYyBpbnQgc3JwX21hcF9maW5pc2hf
ZnIoc3RydWN0IHNycF9tYXBfc3RhdGUgKnN0YXRlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBzcnBfcmVxdWVzdCAqcmVxLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBzcnBfcmRtYV9jaCAqY2gsIGludCBzZ19uZW50cywNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKnNnX29mZnNldF9wKQ0K
PiA+IHsNCj4gPiAgICAgICAgICBzdHJ1Y3Qgc3JwX3RhcmdldF9wb3J0ICp0YXJnZXQgPSBjaC0+
dGFyZ2V0Ow0KPiA+ICAgICAgICAgIHN0cnVjdCBzcnBfZGV2aWNlICpkZXYgPSB0YXJnZXQtPnNy
cF9ob3N0LT5zcnBfZGV2Ow0KPiA+IDwuLi4+DQo+ID4gICAgICAgICAgbiA9IGliX21hcF9tcl9z
ZyhkZXNjLT5tciwgc3RhdGUtPnNnLCBzZ19uZW50cywgc2dfb2Zmc2V0X3AsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZXYtPm1yX3BhZ2Vfc2l6ZSk7DQo+ID4gPT09PT0NCj4gPiBB
ZnRlciB0aGF0LCBtcl9wYWdlX3NpemUgaXMgcHJlc3VtYWJseSBwYXNzZWQgdG8gaWJfY29yZSBs
YXllci4NCj4gPg0KPiA+ID09PT09DQo+ID4gaW50IGliX21hcF9tcl9zZyhzdHJ1Y3QgaWJfbXIg
Km1yLCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBpbnQgc2dfbmVudHMsDQo+ID4gICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgaW50ICpzZ19vZmZzZXQsIHVuc2lnbmVkIGludCBwYWdlX3NpemUp
DQo+ID4gew0KPiA+ICAgICAgICAgIGlmICh1bmxpa2VseSghbXItPmRldmljZS0+b3BzLm1hcF9t
cl9zZykpDQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4NCj4g
PiAgICAgICAgICBtci0+cGFnZV9zaXplID0gcGFnZV9zaXplOw0KPiA+DQo+ID4gICAgICAgICAg
cmV0dXJuIG1yLT5kZXZpY2UtPm9wcy5tYXBfbXJfc2cobXIsIHNnLCBzZ19uZW50cywgc2dfb2Zm
c2V0KTsNCj4gPiB9DQo+ID4gRVhQT1JUX1NZTUJPTChpYl9tYXBfbXJfc2cpOw0KPiA+ID09PT09
DQo+ID4gQ29uc2VxdWVudGx5LCB0aGUgcGFnZSBzaXplIGNhbGN1bGF0ZWQgaW4gc3JwIGRyaXZl
ciBpcyBzZXQgdG8gaWJtci5wYWdlX3NpemUuDQo+ID4NCj4gPiBDb21pbmcgYmFjayB0byByeGUs
IHRoZSBkZXZpY2UgYXR0cmlidXRlIGlzIHNldCBoZXJlOg0KPiA+ID09PT09DQo+ID4gcnhlLmMN
Cj4gPiA8Li4uPg0KPiA+IC8qIGluaXRpYWxpemUgcnhlIGRldmljZSBwYXJhbWV0ZXJzICovDQo+
ID4gc3RhdGljIHZvaWQgcnhlX2luaXRfZGV2aWNlX3BhcmFtKHN0cnVjdCByeGVfZGV2ICpyeGUp
DQo+ID4gew0KPiA+ICAgICAgICAgIHJ4ZS0+bWF4X2lubGluZV9kYXRhICAgICAgICAgICAgICAg
ICAgICA9IFJYRV9NQVhfSU5MSU5FX0RBVEE7DQo+ID4NCj4gPiAgICAgICAgICByeGUtPmF0dHIu
dmVuZG9yX2lkICAgICAgICAgICAgICAgICAgICAgPSBSWEVfVkVORE9SX0lEOw0KPiA+ICAgICAg
ICAgIHJ4ZS0+YXR0ci5tYXhfbXJfc2l6ZSAgICAgICAgICAgICAgICAgICA9IFJYRV9NQVhfTVJf
U0laRTsNCj4gPiAgICAgICAgICByeGUtPmF0dHIucGFnZV9zaXplX2NhcCAgICAgICAgICAgICAg
ICAgPSBSWEVfUEFHRV9TSVpFX0NBUDsNCj4gPiAgICAgICAgICByeGUtPmF0dHIubWF4X3FwICAg
ICAgICAgICAgICAgICAgICAgICAgPSBSWEVfTUFYX1FQOw0KPiA+IC0tLQ0KPiA+IHJ4ZV9wYXJh
bS5oDQo+ID4gPC4uLj4NCj4gPiAvKiBkZWZhdWx0L2luaXRpYWwgcnhlIGRldmljZSBwYXJhbWV0
ZXIgc2V0dGluZ3MgKi8NCj4gPiBlbnVtIHJ4ZV9kZXZpY2VfcGFyYW0gew0KPiA+ICAgICAgICAg
IFJYRV9NQVhfTVJfU0laRSAgICAgICAgICAgICAgICAgPSAtMXVsbCwNCj4gPiAgICAgICAgICBS
WEVfUEFHRV9TSVpFX0NBUCAgICAgICAgICAgICAgID0gMHhmZmZmZjAwMCwNCj4gPiAgICAgICAg
ICBSWEVfTUFYX1FQX1dSICAgICAgICAgICAgICAgICAgID0gREVGQVVMVF9NQVhfVkFMVUUsDQo+
ID4gPT09PT0NCj4gPiByeGVfaW5pdF9kZXZpY2VfcGFyYW0oKSBzZXRzIHRoZSBhdHRyaWJ1dGVz
IHRvIHJ4ZV9kZXYtPmF0dHIsIGFuZCBpdCBpcyBsYXRlciBjb3BpZWQNCj4gPiB0byBpYl9kZXZp
Y2UtPmF0dHJzIGluIHNldHVwX2RldmljZSgpQGNvcmUvZGV2aWNlLmMuDQo+ID4gU2VlIHRoYXQg
dGhlIHBhZ2Ugc2l6ZSBjYXAgaXMgaGFyZGNvZGVkIHRvIDQwOTYgYnl0ZXMuIEkgc3VzcGVjdCB0
aGlzIGxlZCB0bw0KPiA+IGluY29ycmVjdCBwYWdlX3NpemUgYmVpbmcgc2V0IHRvIGlibXIucGFn
ZV9zaXplLCByZXN1bHRpbmcgaW4gdGhlIGtlcm5lbCBjcmFzaC4NCj4gPg0KPiA+IEkgdGhpbmsg
cnhlIGRyaXZlciBpcyBtYWRlIHRvIGJlIGFibGUgdG8gaGFuZGxlIGFyYml0cmFyeSBwYWdlIHNp
emVzLg0KPiA+IFByb2JhYmx5LCB3ZSBjYW4ganVzdCBtb2RpZnkgUlhFX1BBR0VfU0laRV9DQVAg
dG8gZml4IHRoZSBpc3N1ZS4NCj4gPiBXaGF0IGRvIHlvdSBndXlzIHRoaW5rPw0KPiA+DQo+ID4g
VGhhbmtzLA0KPiA+IERhaXN1a2UgTWF0c3VkYQ0KPiA+DQoNCg==
