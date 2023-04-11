Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13C6DCFD1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKCpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDKCpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 22:45:02 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Apr 2023 19:44:57 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF42728;
        Mon, 10 Apr 2023 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1681181098; x=1712717098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8cahzdQXoo322TwVfF2cvOhqoTIwj9vSbl9swLVhNM0=;
  b=E0Pte/n87EpsxCutyBhwrhMAvpM809HIf/7GOODdGZBWyHvlmToi1mjD
   pJF6sd0bSzAz1c4YRIkHjVEcZEgwydMrsyokIMt7zRffKBOSM54A6L3M5
   yfj7wg7enNFYEREFR92LPdYo0TfgA5lOZp3HYmZ3T55YLyzKwEhb4iXOl
   iMZdHoUv8vBL6eC1Tpnh9tYGLUSi56pi/N4lRk4r2brqzEeXD7uV1HdlG
   ZteEauflcEkOug5+Sw4NQRPXZSp9AgJSTPu/fHPgahO9gZd2vXqXVl2mW
   Xm5zQfoTC2mIHMQpZ5EaDsgNly4fbuEn6muKh3wXDIf5BIe7Eq2m6FPet
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="89894285"
X-IronPort-AV: E=Sophos;i="5.98,335,1673881200"; 
   d="scan'208";a="89894285"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 11:43:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMx8+iit2AGC6TNkYrwlWs7k1SgCO8zJsyLuPBUuX6/xkEB5ziAq9Y1v+vTvFtxgvrzewwsTfwDKQScglUA3rEzt1Rv9z/EOJR2LbKOB7xBYG7JJ2mkdOQRlqWzhJzEX/96E58kal12+6fgz10A+69/9XrJspwvWv7LV1Chl5MmpKmMR8VLpijuqIBCd0iSK5fS8r+XumFobE6A/bJWJYrttzY6x3GZ2H7spkw4Pk5eJ+ygYX1Xa0U/XdpXg7Q8NjIUez3Y06dT4+FP3hoklIZWGlM0j4ffDN7JjjX+LvGDcmWufBeV85+P/VqIfevEIu7oYbqXVnqYvSTD38uustg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cahzdQXoo322TwVfF2cvOhqoTIwj9vSbl9swLVhNM0=;
 b=OSM2pSB0M6tkWOhqqBNa4BdCZLcO2FZ6dy1YmSXcXndc2fCE0CEyBss5T8TqmTWP//Kz9MxGnADgLiea1eYDyfrxGAQObybnpzp0lCtBSRzVVUBwpQBzCfd0Jp3YfptmfMBYQpIIt6+xseFIwnocjCWiVjh60BUZBG7BXw8Jzdd/51StFHRjzi8t4ydZDT/UclIQCng0NfO5IJDA7lFDfG5puioyc1mkKVoktcQlvPsygUT73/hHKxb9uZP/bmpxWf/P7prWObWb+/JSwATEHovVnTQpqpyoK17mO6nKInMVy+3bAvC/C2DdiGkc1GDAmT7QvfnkElgvvoP9XZRcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 (2603:1096:400:3b3::10) by TYAPR01MB5817.jpnprd01.prod.outlook.com
 (2603:1096:404:805a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 02:43:46 +0000
Received: from TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::3077:9807:4bb6:b7]) by TY3PR01MB10931.jpnprd01.prod.outlook.com
 ([fe80::3077:9807:4bb6:b7%7]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 02:43:46 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Leon Romanovsky <leon@kernel.org>
CC:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Topic: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Thread-Index: AQHZa3fG6HzoG7hX5EKVX5MOq2N4oK8kc0uAgAARXoCAAONEAA==
Date:   Tue, 11 Apr 2023 02:43:46 +0000
Message-ID: <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
In-Reply-To: <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB10931:EE_|TYAPR01MB5817:EE_
x-ms-office365-filtering-correlation-id: 9b2b7bf8-6f27-4f2b-02dc-08db3a369260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ihbpCYGyoahAJnH6X7Lh0chZY6OknMtPDRaAie4UJVp//1IdDlmFZ4bNj3ROwdINBtw1G/8puFFq/dXyzyF7PHAJ4Ne0xoQH1clt5WcLLlgrId4nZO6gvLx5LQ3AW2ch/0s2LBbaEN6ZbYaQlfFiX+nWFuGeJG+nvz9j2Ho8G9KkK6YQ5vWzqTS0QF4k9YnXv1f0AJcMbS+8gwQrLd5s8sZfyi3TAieTvpWgsNwXaCh6F7fDNisjhH+Vx3pv7bfyzDYJHXeijPGvuoOaoL/PYXNAB4d/7C+GL3x/dEEXbOm9aL0cL0qbqxlZebOJmR8O1b2XvQLq2UFWV0L8Gy/CMLyVBUM3FVBag6rx79kjF4z+QtYNCikB0WaWU1u37R1gL225yOhEbj9ZvS7E8qXvFpNx6pgkrRthOvk9ZPoihjArTWIsrUw/1sm4ZipJrB+695GPs/xHPkHSJE2cjsj95WwsUj2Wkw0Piq62dzXv9UmwVtj8ZWaHDLoXv6ClgG6d5kz+qn20PkhgMf/aq6Y48wSaIqSJ5sSFg0+Qf2xXorTGvO51ybEAbXJZGJ0HSd/q2RPzd5ECCZKwPY6eGoozLlu+r0ykY4YQs39VNdiTm7/Zy4pNNldI1FIt68s1kTz1J20YpYmq7V0Sh80kn6N1O6BtJBBNw6paEScI6xjh+jA+4OeSoySr897HaYbJRLgIMnvFPCDsXzzrycry2NhNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10931.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(1590799018)(71200400001)(45080400002)(478600001)(6512007)(316002)(110136005)(53546011)(26005)(6506007)(186003)(54906003)(6486002)(91956017)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(8936002)(66556008)(38100700002)(38070700005)(122000001)(31696002)(86362001)(83380400001)(85182001)(36756003)(82960400001)(2616005)(31686004)(66899021)(1580799015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzE2V1VkM1g2amloeHBYOFRwSHplY3pGREVObXhLUFlIR2svR1hueHkrWGhv?=
 =?utf-8?B?bnhLZllKc1JCV0h0cEl4NysyQ0NhVm9NZEtNVWhwbE9hL1VqRlZpM1hHYnBw?=
 =?utf-8?B?aUFoRDBUOGQ5V2FWR1d5TkJBWFBMbVc4UWdNUGhHS0dpTit5TzdFV3JUQ3dS?=
 =?utf-8?B?MHJ5WERMaVV5RTJyb2gwRFZ2ZU1HRUEweW91c3hJdm5mTHFpaGxPR1FQenlK?=
 =?utf-8?B?WGg4VVFvajN3VnVpMEticXZ3OXpmWkdBWjhHaEpMRjNHV2ZHTWI2U0Jka3lY?=
 =?utf-8?B?UjVxdlBERGxIb1dEOWxkQ3VsZEpqOG90UFRkTlY0ZzFaMGE4NHoyQWVncFZM?=
 =?utf-8?B?SzNCTkprdk5FR1RLeGsvdzkxMng1ZE5sN0J6UlRHWUhwcFpHVTRvSUsyS0Rw?=
 =?utf-8?B?TnUwc21RejErS2xGTk9hY3h4YW9QNVJ3TTBiYmR6QVM5bURod3FlaXJZNTBz?=
 =?utf-8?B?WWFtR0tleG11VXhMVGFVOVUxeENONzdiUXdxSS9jdTRVbFcxRE5RRStScytr?=
 =?utf-8?B?bnc3SVdDSmJIeC9wK0tUTWl0UkdESzdTbTRPaWxiVWxXTTRPL2hRc2FpMUc2?=
 =?utf-8?B?K2c3ME5DQmVTeEJWWUZOYnpxNHVvL3FsYnh3R29td0pCdFdyU0Z2UXZBbUN0?=
 =?utf-8?B?TEk5MEFCd1VjbjVkMlpHeWk0SWIzcWNISlZHRmRkMUtNL092T1B5bUlBQmN3?=
 =?utf-8?B?Zk1BSFZRbnhUSGR2SjdOQUdCQW0xVGtPejdTZlZTSTRrenNCNHM0OXc2dHA3?=
 =?utf-8?B?aE5rczFwdU5wNmorN0ZtS2g2d3JrbVM0cUZIS0dVY1YxRFl2UmEydGJ2Q2kx?=
 =?utf-8?B?TVlQRnBydS9BZ1U5dmVKZ3h1TjYxSkFSNzdtaGw4SEpweVNBWkFmeGlUNmtC?=
 =?utf-8?B?aHdzbjNrREVIVGt0Z2V2Q0tTeFhNcmtBUjFYdmpxZGhCcjI4MXJiNEtBVUgv?=
 =?utf-8?B?RjFRL1piNUpXQlB4OW82MWJhSnoyTzF3UjFFbElCeVdRY25KUVZNdkFacE9X?=
 =?utf-8?B?bUJvZU1uVzRKSFNwWUlld3lIUWlWWWlKT0pLeGlOY2NVQTA2MVJSL01RV1BM?=
 =?utf-8?B?UTdZSGs5Yy9NanFHTS9WcEZHMVppZ2M2V3haVlg1LzFQNEZEdVlzRVhUN1Zn?=
 =?utf-8?B?RTJ5dC9oSXp2YWsyU08zSlZOR3ZKTTg4bTEwbmJaVEN1Y2tESDVrbDJmdjB1?=
 =?utf-8?B?MVFDelprL044azl0MlRVejduOHFnWE9ibk14Mkl0RHBxMGRCYTAxTUZVUS92?=
 =?utf-8?B?WnBmSVpucENXcTArMUt0dWNHeDVSTHp6Q3RBQnJnanJ5QnBTRllFaVNiVERR?=
 =?utf-8?B?U2NzWWczcWxIU1VBSWRDVmxVVVVwMTdZNGc2TENCTVpyVktyWUcyZmNGWGRI?=
 =?utf-8?B?OXpjMGZZb0ZFUjd2WFJpTlljbFFmdEduWWc1aHpJRUN6RzBQSi9ibnNiVVBE?=
 =?utf-8?B?bmp1aHlLK1hKQXIwcXMyNFZ3U28xbUg2dFcwcGZRU1duSE1zdmNiMmZmMnlJ?=
 =?utf-8?B?b3VEMERpVTRjdXdUcXJBS1ZRSjNDWldjMDVlSjljZTNyQ2NsNUcwdktSRHVu?=
 =?utf-8?B?cE50Z1NCUVJBMHRzdjNoclJOdSsrdGwzTTBucmJUOTlONHdPeDBoZ0JGNzU2?=
 =?utf-8?B?M0JJcnp2YndtOEYxR1hXV0RCWXd4U3ZLanpOMVFXQ3lrTG9NYlNLdFIya0xW?=
 =?utf-8?B?Z0ZwYW1QaS82SlU5bm1LNmhVdEozamdlRzBYWXJmZjFKMUhQUlJYVndYMVg0?=
 =?utf-8?B?Q21HV0JnVEkvblpZMkdGR3JuOEtMMWNtSjdiRUozZTJ1dWp4RnZBMUN1cUVU?=
 =?utf-8?B?Z3htWHYvR2tUbXo4Wmhvd1hEc3IvWWUyQTMwaURYUFJGY1RkRFc3dHNnb210?=
 =?utf-8?B?bG5rSG5UdEh4VG1GaGZldnZ6azd4WFQ1TTdZOHdPWDdONjlWUFVVMlBVUXVZ?=
 =?utf-8?B?R1ZwMnBWemVaYzBSVlhGYW96TFRFM1NTQTI0UEZUaE0ycFRqWGRFeWxic3BH?=
 =?utf-8?B?WlUwMG1UYWF2TUV6aDJpYTIyMitSQU5yanFpbWlhRkdFZm5QaUJ4dGEzSENJ?=
 =?utf-8?B?dTBUUkIrVVVUQVFjaVh5OWRsc1NWamYraWhyeGZYdGNpeHdGOTdidEd3K0N5?=
 =?utf-8?B?UmtCOXhzRTJ4aHBpS3Y1Vm42c2RzQnVVZll2Vjd5c3p1OVRYdGtiSFNnWGtK?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A86A90D7AB95E4E92DC58FBC99F0BB0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R3GBIBIKGCUzDqNinmJ2Km5/g/tZW7U1ZlJdcB63nNlyCUj0oDBbmSnd5+MIKj0Gko54ZnxA5urkiWOUTLdtJrfVs/Vh547uA1o1/GPQtlhWXwmCPDA3xLrlLf8gPrYg+wRh2YGpeRWWwDWSYfRzMnZNQe6bUTHGqg4c1ywnunV0sMcEHsobe/+1AF7Ao2iqabT91dWzm9nhH1SIaU/2fQnhrOftmIyVJqigw9Lr1mMKjL7zo7fIvkm2s+dZYaUNhNjSkgkrmt4sOen84U6hn6y91Nrohku9Jp7CNNgDbjIWfkdsbJyCQkxBTxckvRQul5p28Q95SXlcMkNPuQ1AQ6V3glYhlgPgZqsOrzgZOXACezvuHMBk9T1aSixtykdiNPDqj5df1vIpX8Xt7hdf0BapPaxftre+lW2joIqJ0bPBHQ5U0ysGIV8tiuFXWJv5O7nHglOdxg4FJMFzycGrChy3rSBeGhJk5qHo5KslRSFUBrfZgxG3cdFt5tHmXJlBMtRVK5ruJdFOHG7n8T7QJOhFeNni96krstOaw051rNkxqEO3BPimyYN+eKhWCptk5sfXklgzjnEaXijekV3bT0+74jwGMFA1BAw13fjjAGhi5EmxhauRHvWPVRYEUKAPV8T+fS49stQGUTyFOIe1fklrjZhK1QkcRgkPzvd6Sv1dZBFD8DIobExRq0f8x0NIAoPZ9mbm1VPO3MNHJjQVoTxe9oiNJxDfZTT/x9RD9C1oxNY+bQrc2j9xPHdw8W73klKpul/SpYwS9dk8SqBmRv9sX1MLF5zDDMfPSfwM3ckHDmAPofCoZMvjIHRrHLxqC5mhOAX5OVqoZlFa9w8BG8xMoqhs3X27ksUKlqhmJyIJA9llzWafWi7eASDAnGsV
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10931.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2b7bf8-6f27-4f2b-02dc-08db3a369260
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 02:43:46.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1D5Coi7DpORDOi3/dAL9DtYo4IXKvTEi8zxjKfwfKm99byp6dq6BOi7CQ++bulaUrMolkfnzy3lhq0Uw0cM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5817
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDEwLzA0LzIwMjMgMjE6MTAsIEd1b3FpbmcgSmlhbmcgd3JvdGU6DQo+IA0KPiANCj4g
T24gNC8xMC8yMyAyMDowOCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0KPj4gT24gTW9uLCBBcHIg
MTAsIDIwMjMgYXQgMDY6NDM6MDNBTSArMDAwMCwgTGkgWmhpamlhbiB3cm90ZToNCj4+PiBUaGUg
d2FybmluZyBvY2N1cnMgd2hlbiBkZXN0cm95aW5nIFBEIHdob3NlIHJlZmVyZW5jZSBjb3VudCBp
cyBub3QgemVyby4NCj4+Pg0KPj4+IFByZWNvZGl0aW9uOiBjbHRfcGF0aC0+cy5jb25fbnVtIGlz
IDIuDQo+Pj4gU28gMiBjbSBjb25uZWN0aW9uIHdpbGwgYmUgY3JlYXRlZCBhcyBiZWxvdzoNCj4+
PiBDUFUwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENQVTENCj4+PiBpbml0X2Nv
bm5zIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwNCj4+PiDCoMKgIGNyZWF0ZV9jbSgpIC8vIGEuIGNvblswXSBjcmVhdGVkwqDCoMKg
wqDCoMKgwqAgfA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgYScuIHJ0cnNf
Y2x0X3JkbWFfY21faGFuZGxlcigpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqDCoCBydHJzX3JkbWFfYWRkcl9yZXNvbHZlZCgpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgwqDCoMKgIGNyZWF0ZV9jb25fY3FfcXAoY29uKTsgPDwgY29uWzBdDQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCB9DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgaW4gdGhpcyBtb21lbnQsIHJlZmNudCBvZiBQRCB3YXMgaW5jcmVhc2Vk
IHRvIDIrDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+PiDCoMKgIGNyZWF0
ZV9jbSgpIC8vIGIuIGNpZCA9IDEsIGZhaWxlZMKgwqDCoMKgwqDCoCB8DQo+Pj4gwqDCoMKgwqAg
ZGVzdHJveV9jb25fY3FfcXAoKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
DQo+Pj4gwqDCoMKgwqDCoMKgIHJ0cnNfaWJfZGV2X3B1dCgpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGRldl9mcmVlKCnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpYl9kZWFsbG9jX3BkKGRldi0+aWJfcGQpIDw8IFBEIHwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlzIGRlc3Ryb3llZCwgYnV0IHJlZmNudCBpc8KgwqDCoCB8DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGlsbCBncmVhdGVyIHRoYW4gMMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwNCj4+PiB9DQo+Pj4NCj4+PiBTaW1wbHksIEhlcmUgd2UgY2FuIGF2b2lkIHRoaXMg
d2FybmluZyBieSBpbnRyb2R1Y2luZyBjb25uIG93biBmbGFnIHRvDQo+Pj4gdHJhY2sgaWYgaXRz
IGNsZWFudXAgc2hvdWxkIGRyb3AgdGhlIFBELg0KPj4+DQo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiDCoCBybmJkX2NsaWVudCBMNTk3OiBN
YXBwaW5nIGRldmljZSAvZGV2L252bWUwbjEgb24gc2Vzc2lvbiBjbGllbnQsIChhY2Nlc3NfbW9k
ZTogcncsIG5yX3BvbGxfcXVldWVzOiAwKQ0KPj4+IMKgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUg
XS0tLS0tLS0tLS0tLQ0KPj4+IMKgIFdBUk5JTkc6IENQVTogMCBQSUQ6IDI2NDA3IGF0IGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Bvb2wuYzoyNTYgX19yeGVfY2xlYW51cCsweDEzYS8w
eDE3MCBbcmRtYV9yeGVdDQo+Pj4gwqAgTW9kdWxlcyBsaW5rZWQgaW46IHJwY3JkbWEgcmRtYV91
Y20gaWJfaXNlciBybmJkX2NsaWVudCBsaWJpc2NzaSBydHJzX2NsaWVudCBzY3NpX3RyYW5zcG9y
dF9pc2NzaSBydHJzX2NvcmUgcmRtYV9jbSBpd19jbSBpYl9jbSBjcmMzMl9nZW5lcmljIHJkbWFf
cnhlIHVkcF90dW5uZWwgaWJfdXZlcmJzIGliX2NvcmUga21lbSBkZXZpY2VfZGF4IG5kX3BtZW0g
ZGF4X3BtZW0gbmRfDQo+Pj4gdm1lIGNyYzMyY19pbnRlbCBmdXNlIG52bWVfY29yZSBuZml0IGxp
Ym52ZGltbSBkbV9tdWx0aXBhdGggc2NzaV9kaF9yZGFjIHNjc2lfZGhfZW1jIHNjc2lfZGhfYWx1
YSBkbV9taXJyb3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGRtX21vZA0KPj4+IMKgIENQVTogMCBQ
SUQ6IDI2NDA3IENvbW06IHJuYmQtY2xpZW50LnNoIEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQg
Ni4yLjAtcmM2LXJvY2UtZmx1c2grICM1Mw0KPj4+IMKgIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3Rh
bmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0xLjE2LjAtMC1nZDIzOTU1
MmNlNzIyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4+PiDCoCBSSVA6IDAwMTA6X19y
eGVfY2xlYW51cCsweDEzYS8weDE3MCBbcmRtYV9yeGVdDQo+Pj4gwqAgQ29kZTogNDUgODQgZTQg
MGYgODQgNWEgZmYgZmYgZmYgNDggODkgZWYgZTggNWYgMTggNzEgZjkgODQgYzAgNzUgOTAgYmUg
YzggMDAgMDAgMDAgNDggODkgZWYgZTggYmUgODkgMWYgZmEgODUgYzAgMGYgODUgN2IgZmYgZmYg
ZmYgPDBmPiAwYiA0MSBiYyBlYSBmZiBmZiBmZiBlOSA3MSBmZiBmZiBmZiBlOCA4NCA3ZiAxZiBm
YSBlOSBkMCBmZSBmZg0KPj4+IMKgIFJTUDogMDAxODpmZmZmYjA5ODgwYjZmNWYwIEVGTEFHUzog
MDAwMTAyNDYNCj4+PiDCoCBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmOTk0MDFmMTVk
NmE4IFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPj4+IMKgIFJEWDogMDAwMDAwMDAwMDAwMDAwMSBS
U0k6IGZmZmZmZmZmYmFjODIzNGIgUkRJOiAwMDAwMDAwMGZmZmZmZmZmDQo+Pj4gwqAgUkJQOiBm
ZmZmOTk0MDFmMTVkNmQwIFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAw
MDENCj4+PiDCoCBSMTA6IDAwMDAwMDAwMDAwMDJkODIgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIx
MjogMDAwMDAwMDAwMDAwMDAwMQ0KPj4+IMKgIFIxMzogZmZmZjk5NDEwMWVmZjIwOCBSMTQ6IGZm
ZmZiMDk4ODBiNmY2YTAgUjE1OiAwMDAwMDAwMGZmZmZmZTAwDQo+Pj4gwqAgRlM6wqAgMDAwMDdm
ZTExMzkwNDc0MCgwMDAwKSBHUzpmZmZmOTk0MTNiYzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDANCj4+PiDCoCBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KPj4+IMKgIENSMjogMDAwMDdmZjZjZGU2NTZjOCBDUjM6IDAwMDAwMDAwMWYx
MDgwMDQgQ1I0OiAwMDAwMDAwMDAwMTcwNmYwDQo+Pj4gwqAgRFIwOiAwMDAwMDAwMDAwMDAwMDAw
IERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4+PiDCoCBEUjM6
IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAw
MDQwMA0KPj4+IMKgIENhbGwgVHJhY2U6DQo+Pj4gwqDCoCA8VEFTSz4NCj4+PiDCoMKgIHJ4ZV9k
ZWFsbG9jX3BkKzB4MTYvMHgyMCBbcmRtYV9yeGVdDQo+Pj4gwqDCoCBpYl9kZWFsbG9jX3BkX3Vz
ZXIrMHg0Yi8weDgwIFtpYl9jb3JlXQ0KPj4+IMKgwqAgcnRyc19pYl9kZXZfcHV0KzB4NzkvMHhk
MCBbcnRyc19jb3JlXQ0KPj4+IMKgwqAgZGVzdHJveV9jb25fY3FfcXArMHg4YS8weGEwIFtydHJz
X2NsaWVudF0NCj4+PiDCoMKgIGluaXRfcGF0aCsweDFlNy8weDlhMCBbcnRyc19jbGllbnRdDQo+
Pj4gwqDCoCA/IF9fcGZ4X2F1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDEwLzB4MTANCj4+PiDC
oMKgID8gbG9ja19pc19oZWxkX3R5cGUrMHhkNy8weDEzMA0KPj4+IMKgwqAgPyByY3VfcmVhZF9s
b2NrX3NjaGVkX2hlbGQrMHg0My8weDgwDQo+Pj4gwqDCoCA/IHBjcHVfYWxsb2MrMHgzZGQvMHg3
ZDANCj4+PiDCoMKgID8gcnRyc19jbHRfaW5pdF9zdGF0cysweDE4LzB4NDAgW3J0cnNfY2xpZW50
XQ0KPj4+IMKgwqAgcnRyc19jbHRfb3BlbisweDI0Zi8weDVhMCBbcnRyc19jbGllbnRdDQo+Pj4g
wqDCoCA/IF9fcGZ4X3JuYmRfY2x0X2xpbmtfZXYrMHgxMC8weDEwIFtybmJkX2NsaWVudF0NCj4+
PiDCoMKgIHJuYmRfY2x0X21hcF9kZXZpY2UrMHg2YTUvMHhlMTAgW3JuYmRfY2xpZW50XQ0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
Pj4+IC0tLQ0KPj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIHwg
NCArKysrDQo+Pj4gwqAgZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmggfCAx
ICsNCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLWNsdC5jIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3VscC9ydHJzL3J0cnMtY2x0LmMNCj4+PiBpbmRleCBjMjA2NWZjMzNhNTYu
LjRjOGY0MmU0NmUyZiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3J0
cnMvcnRycy1jbHQuYw0KPj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJz
LWNsdC5jDQo+Pj4gQEAgLTE2NjQsNiArMTY2NCw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2Nvbl9j
cV9xcChzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTk9NRU07DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgY2x0X3BhdGgtPnMuZGV2X3JlZiA9IDE7DQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIGNvbi0+aGFzX2RldiA9IHRydWU7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHF1ZXJ5X2Zh
c3RfcmVnX21vZGUoY2x0X3BhdGgpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB3cl9saW1pdCA9
IGNsdF9wYXRoLT5zLmRldi0+aWJfZGV2LT5hdHRycy5tYXhfcXBfd3I7DQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIC8qDQo+Pj4gQEAgLTE2OTAsNiArMTY5MSw3IEBAIHN0YXRpYyBpbnQgY3JlYXRl
X2Nvbl9jcV9xcChzdHJ1Y3QgcnRyc19jbHRfY29uICpjb24pDQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHdyX2xpbWl0ID0gY2x0X3BhdGgtPnMuZGV2LT5pYl9kZXYtPmF0dHJzLm1heF9xcF93cjsN
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogU2hhcmVkIGJldHdlZW4gY29ubmVjdGlvbnMgKi8N
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2x0X3BhdGgtPnMuZGV2X3JlZisrOw0KPj4gV2l0aG91
dCBsb29raW5nIGluIHRoZSBjb2RlLCBJIHdvdWxkIGV4cGVjdCBkZXZfcmVmIGZyb20gdGhlIGxp
bmUgYWJvdmUNCj4+IHRvIHBlcmZvcm0gUEQgcHJvdGVjdGlvbi4NCj4gDQo+IEFncmVlZC4NCg0K
U29ycnksIGkgZGlkbid0IGdldCB5b3VyIHBvaW50LiBEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlr
ZSB0aGlzOg0KDQorCQljb24tPmhhc19kZXYgPSB0cnVlOw0KICAJCWNsdF9wYXRoLT5zLmRldl9y
ZWYrKzsNCg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBUaGFua3MsDQo+IEd1b3Fpbmc=
