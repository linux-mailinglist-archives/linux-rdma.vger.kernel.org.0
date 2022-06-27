Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1DD55D2BD
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiF0Grp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiF0Grp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 02:47:45 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9A55A1;
        Sun, 26 Jun 2022 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656312463; x=1687848463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Up7TVfnF7BZu96RF80UpC/mlT56EODQB5yZqGHh+zc=;
  b=WW5lYs6opcNneC7DQnaSQ6vtHKG+VyDiHHuvLcEBc2wYePN4a+sEyvWR
   zCxUbdtwuAbZsPQRb1W544/DWDn/VkgJy9LoHsz8FXru7MJaOz8ba0xV7
   A8UQ7+NAJJGswRB7MDvU3YT+Bi2jaZCrqixDqXoYKa/vNEaz+H8/LPvKG
   3B93XJjACkUiWl14jlZAkGsn3qtu1ehn5Efz3oeB63UifO66ih9c/CU7e
   +BvOukZjAQNVAbvr3kEzEFinLs2+JyEVdAXfT3VuzdYBtyyOHBj7wWplK
   H2vSp/nF/SNks3/tTWcPls7sm+KPpSuPkWAS/4XW6m1oeytwhjePb4pF3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="59142961"
X-IronPort-AV: E=Sophos;i="5.92,225,1650898800"; 
   d="scan'208";a="59142961"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 15:47:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXT8BF0X9pLAgXoXpiEECsyhgakR9z/dqliFizwYxnkXuCP8NAxele3YzGR44WKMIjdrynap5UAFOSqv/qFtqRQ/bIvND/mDmMtvBYEOl4i0IYbQYE9Ant9WRzADLByg6owYWlJXURMuljNFqoR53K7G1vRRyhJB+VIVJzMEvrC/KRnOZazwQsn9jJ+TDpPuAkR3gNpgkRJrkFgp7EpAbQ7ZpLnI6vrnnWsmsXXMxxrDJACeXHW9eS1qTOmESe7X7Sds9PTrnqM+YwEUkwIDaIIw/3c1biDg8OUPVbXTi+x3JtsHn8ens7SzDN8f9GooO5eTrRIgbU7pXHIcMtFD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Up7TVfnF7BZu96RF80UpC/mlT56EODQB5yZqGHh+zc=;
 b=bAVkYEQ3dqyn0c4JV2AI7JaebLZA//8LZlJF2rrXo47F7Xyw4xPpCOCCrLQfTIdaLUo7myVA86UUXHaqfzZf+fKvowwilnc1Hgwgxj58uMCMKtRaL7XQwpiysOe73KTiYYY/aRcOuy763vjRx2mf7CcsPJNizhPjfYyOU0ninOwiYJ+wYe8IXarmbOPgIX4hdXg2qd5ZBGMNq0GPp0R8nQbP5QyrxUuEhfjlaXxDo7GXQrQi7rS1TPc+wd9Vpa+ZX3BGkU+Y6eqyKr+fLKbgqw1ySVl8gAtd8CXZYiLEFV1Sy2aGRfUdLKYLrzeDY17Oxb7f4avykwScLNUCpyEPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Up7TVfnF7BZu96RF80UpC/mlT56EODQB5yZqGHh+zc=;
 b=Za7RNt1I1+Ryf2xVpdNqaP+mW8bDF2SSLrlnoAm/vtigPh2Ok0lK/kEHpdBdA3RY6/wRWzGUEs8oFYIDntVlLlD0lfyxVDTCOs97xrwaakHTCLA0hnGiLu5h0n3oZxUPT62QP7OI7PphfKkBWHnC65bA0EoWY+a83JGCkLd3eno=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OSBPR01MB1575.jpnprd01.prod.outlook.com (2603:1096:603:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 06:47:36 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::416:8e9b:ee26:d5c8%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:47:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Thread-Topic: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Thread-Index: AQHYh35JLQJOb/7P20ey8N/XTZsfNa1fLQgAgAAHiQCAAAYbgIADmeiA
Date:   Mon, 27 Jun 2022 06:47:36 +0000
Message-ID: <343aa894-796f-181e-1691-15cb8659ab06@fujitsu.com>
References: <20220624040253.1420844-1-lizhijian@fujitsu.com>
 <20220624225908.GA303931@nvidia.com>
 <5a4a42fe-c5c8-63fe-365f-e6c74a279cc2@acm.org>
 <20220624234757.GD4147@nvidia.com>
In-Reply-To: <20220624234757.GD4147@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24546f2b-3450-4569-9c22-08da5808ebe8
x-ms-traffictypediagnostic: OSBPR01MB1575:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUZ+0edNGWKvyO50Xn+SnzvrpJ/kk1sKwdGBJ8jgaX9SW8ODsphRDr6vuwmzHLG0yeGZ8/ipTMk01XUKQIF0v0hr3YdHHjadoi7xTbmSK62e54gZv3c+7zawIuhw5LdPcAr+I/sN5Y2p5N2435SYVI2b+f1MxYZfZmY3faJbPcT6bhZJHpcFoq/zUV3UzmqUHLHYXy+hW8y2MaM2ukweR4d4CEnIGE/lx7C//jRykheyiQVkd2Es4IUXBIMxGtWPeaZVgjk56Ib3Ez8DzY1jfGVmJX01mfZF3bLjoXoYR0ENYrv69bVQylqW22EI090lKnnS6nXSA66hqu969GAuU4B1til63Yc/Zsy/0SmKni92s0D65UdpUkWSU5Ixgu6yfq1VIJrun1jeq0mnMJzBCpbv0GIg96dBKaDvZtKJQNU8Sxyxe7oGqBbBMRgYPTP+8iQjI+tec63TwwVRE/VeVPzZbF3u2XE1vJMJRiyn4W4TCz3V/hla7RKkj8eZD1H2R+a39LtrrFOtL0ZdQBl79LX2ZY0VRPs4/2tW05z0HKkS7RlvqKu5iroNID4amtE4lYBxB/40L+0Xpmq+wiLLTUSV6igfG/du5CVIah/xVqRY7XayTk8H81hjwA3kiJ1XEO34tGzuXZpRRjSY5zawR2rpUt3S51zz9hZ8xKObLSL1DtSHswYYUkMjKxQqYj+f7uva0H9M9ldMzpUEzkI5a1vJspiUj3KHCIt8p2ZdsJeOmF78wZVCmJMRWXEy2iBYvnDDMGie3oCT/Jck8Bo2AFtHjMZNIGeyFcT88QzH98EGEllM4/jBaVVZqP8C2tLjO/VPewpRtq7ljN0wtaCLvq4hVT9OlYpy3Q9/5QzGayY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(66476007)(8676002)(66446008)(66556008)(4326008)(76116006)(66946007)(64756008)(91956017)(2616005)(6512007)(478600001)(31696002)(26005)(186003)(6486002)(8936002)(38070700005)(71200400001)(6506007)(316002)(53546011)(36756003)(85182001)(82960400001)(31686004)(54906003)(2906002)(110136005)(41300700001)(86362001)(122000001)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm95UlhzcmpxN0kyY2NhUHV3dHpqMDQxMmJlTGZJZCtKcGZMMVgrZWRLWkR0?=
 =?utf-8?B?RVNtU3IzMUdvMW1BMmtHa0dwNGZnelR4SEoxZ2xSMTJMcDc1OWw4NWhKeUQ3?=
 =?utf-8?B?Z0FaOTFWdHRsaWFRazNwTForWVVlSVR0Y2FqVVZyRzNpbnl6TzVWSVZId3BK?=
 =?utf-8?B?OUJEUzhvSndFc3FjV0RxMWVTNHRWTnNpNEpQVjlEU1RNMWhtYWxqdmoyZitY?=
 =?utf-8?B?bmdnRy9aaW16UUpSTGJQanRXVnRMN2tqOGUvTVNhTjR4ZnduTGVTdVlKWWVI?=
 =?utf-8?B?ZTFyL2F4UW9abXhZUEhnRGNqSVdzMncwaGlyZHRlbWkxTHJWMGhoOWsxeXc3?=
 =?utf-8?B?c2Y5TVZib3N6Z0llcERqWWVsa2ZPUTVIOHAreDFYbG1XRzZPM1RtUVZkSGw2?=
 =?utf-8?B?V3oxSFh4d0lKOHBibWtBTUlyNW9CUTh1c0d3eklMbm5yT29FMEFBTlNGaUtW?=
 =?utf-8?B?Y3NyVVdxOVY1eXNidEliRk0wME11eTIxSlZTVGdaVkRZRWYyNThsS3V5WkFL?=
 =?utf-8?B?Ym00WHJwTmlFem4yK3BDVkNvSWFyQ3JUMnlSbkdReGtxa0NKbGFZbGhsVWJm?=
 =?utf-8?B?dnBBZlMyQWJiRWR0ald4NTE2blAySzVDS1FqUUs2QmFqc1BTSHVmeW04dkN4?=
 =?utf-8?B?S3ptWmxWeFdUUlNMTlkyZm9RUUdQbEVGTUs2U2kxM3hzVEh0VU1JaTlsMEta?=
 =?utf-8?B?NTZtZDF3YXEyMmtZRWlLZWg3M2JYY0N0b1paK3VLY2Z2dmtsM2M1cExaM3Yy?=
 =?utf-8?B?ampLSU5Uczc3bUlubDBtS0tYWkw4bHBRSEpMVDFneTNsdmNrN25sTG1WSm55?=
 =?utf-8?B?R0NFZmZEc1N5UU9hQkkzWEJkZG12MjluNGZUeFRydVlVS0EreFRyVWNmdW9U?=
 =?utf-8?B?MjVBZGdWUUFad25lVllMSm9KaUdLbi91MU9MTTNoSzVVYmRWRm5tVmFrM0hX?=
 =?utf-8?B?c2lKVjR6dnFPeEpNTHMzVk9KWndGMUhWOVNpMEdoelE2VTdTWnBBdUowWUhn?=
 =?utf-8?B?VEdZWk5yenVFZXJ6Ukh2SmdmaGdzdE4zaSthQkFqeW1qNjNSbmR3M0dXWWVZ?=
 =?utf-8?B?NlFwazFiSkc3WTllK2xHdWJhdTd6VUFqeWxBKzVBRERWRXZNSW5rWm1GVTdS?=
 =?utf-8?B?aDEwcnpkLzhQcVNDVFRMVmVkc0NDcThxeFhVUTZoM21RVHZkVldXYzR6a29M?=
 =?utf-8?B?dFdGbXppUUpYeEpvK3BWWUJGZ05Va2ZLY1BFSUZwaVNua1AxbnIxU3IwajN6?=
 =?utf-8?B?SUZSUUUweitTZTh5cVg4dGlyYzZYYzVsVU1IR0xCTGtvU2tTYWV3NnpCTlVV?=
 =?utf-8?B?aWJOL2VCR0d2MWdQREUwYjFjMk9rc0VTeEN3VHI3UFM5RW1qckhpUTdPRENH?=
 =?utf-8?B?SWhlM0xlNkZHTk5GVFVHTzNob3phdStyRWNpZ1c1aTgwY1lvK09zalFjR1JR?=
 =?utf-8?B?VzA3SlQ0T05TYzBHZnExcGdZZjNvWUcwTXZpMWZGU0xDMGJLTU5ySDh4dEEx?=
 =?utf-8?B?NlBudkVXcFphVTlESXpucXN0ZHhSQ3Fnbng2V0p5RXRTNjdCL3pJVUhnTTF2?=
 =?utf-8?B?OXE4RzcxaWZmZHphUW5ZZWxzSlR2aFZ2MzVqK0ZuSzM4OEFzS1RBekpuTTFm?=
 =?utf-8?B?TTRKdUo2eEswRXlHQ1Z6MFRwSnpqbWcrMUQxcGJmUHRoTUhiaDVyamZwK2hK?=
 =?utf-8?B?V0pHZHBiZzMyR0tPTkV3RlRkMUlEeGN3KzlIMFhESXJXdHZmWk9iRUdlcUNZ?=
 =?utf-8?B?WTZIRFY1UlRoWForNGNhNkJCajdQNU50Yzc2dmtTWGdXa2M0dFlpaEk2VXBo?=
 =?utf-8?B?UE5DaWNWT0R3bU5KaUlnSUdVK2dxUm11dG5NYVA4M0lmKzNtbVIvekRDR09m?=
 =?utf-8?B?TERhKzdDOWRMdDZiVnkxcEFZa3B0YzRwTlRTenlSaE02VkZYNm5XNS90Z2l5?=
 =?utf-8?B?cHV6RXZPVDVKenRqMU1GUk15dTVSaWlTYitTMy9HZFVESUJ4aDZNMDNPWktL?=
 =?utf-8?B?L25wUGt3bWtWQUplaERLTEE5MWR0a1Y1T085M2c2S1dZekZvLzhWNzJzVW5G?=
 =?utf-8?B?OVdxYitTRnBUVStKTjFKZ3hMZ2ErRE9lSnJJZERRNU5Nejg1MHo5TmZ1aGdt?=
 =?utf-8?B?OU9McWM1WjgwRGsxRHhwdDRESHpiQ1VEQWVOYzU3NFV1Y2lzR2JKVml5c2tQ?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F04503606F84448251FEBCDE905BA9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24546f2b-3450-4569-9c22-08da5808ebe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:47:36.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4gWu0MIAWOzfBTcaKe3sy18zl1fL8msGhq88ykzdhP+rWgBVVX2/DQk74skwuLEiDci0yltk7Pd2wrGQv8cEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1575
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseQ0KDQpPbiAyNS8wNi8yMDIyIDA3OjQ3LCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDI0LCAyMDIyIGF0IDA0OjI2OjA2UE0g
LTA3MDAsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4+IE9uIDYvMjQvMjIgMTU6NTksIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4+PiBJIGRvbid0IGV2ZW4gdW5kZXJzdGFuZCBob3cgZ2V0X2Rl
dmljZSgpIHByZXZlbnRzIHRoaXMgY2FsbCBjaGFpbj8/DQo+Pj4NCj4+PiBJdCBsb29rcyB0byBt
ZSBsaWtlIHRoZSBwcm9ibGVtIGlzIHNycF9yZW1vdmVfb25lKCkgaXMgbm90IHdhaXRpbmcgZm9y
DQo+Pj4gb3IgY2FuY2VsaW5nIHNvbWUgb3V0c3RhbmRpbmcgd29yay4NCj4+IEhpIEphc29uLA0K
Pj4NCj4+IE15IGNvbmNsdXNpb25zIGZyb20gdGhlIGNhbGwgdHJhY2VzIGluIExpJ3MgZW1haWwg
YXJlIGFzIGZvbGxvd3M6DQo+PiAqIHNjc2lfaG9zdF9kZXZfcmVsZWFzZSgpIGNhbiBnZXQgY2Fs
bGVkIGFmdGVyIHNycF9yZW1vdmVfb25lKCkuDQo+PiAqIHNycF9leGl0X2NtZF9wcml2KCkgdXNl
cyB0aGUgaWJfZGV2aWNlIHBvaW50ZXIuIElmIHNycF9yZW1vdmVfb25lKCkgaXMNCj4+IGNhbGxl
ZCBiZWZvcmUgc3JwX2V4aXRfY21kX3ByaXYoKSB0aGVuIGEgdXNlLWFmdGVyLWZyZWUgaXMgdHJp
Z2dlcmVkLg0KPiBTaG91bGRuJ3Qgc3JwX3JlbW92ZV9vbmUoKSB3YWl0IGZvciB0aGUgc2NzaV9o
b3N0X2RldiB0byBjb21wbGV0ZQ0KPiBkZXN0cnVjdGlvbj8gQ2xlYXJseSBpdCBjYW5ub3QgY29u
dGludWUgdG8gZXhpc3Qgb25jZSB0aGUgSUIgZGV2aWNlDQo+IGhhcyBiZWVuIHJlbW92ZWQNClll
cywgdGhhdCBtYXRjaCBteSBmaXJzdCB0aG91Z2h0LCBidXQgaSBkaWRuJ3Qga25vdyB0aGUgZXhh
Y3Qgd2F5IHRvIG5vdGlmeSBzY3NpIHNpZGUgdG8gZGVzdHJveQ0KaXRzZWxmIGJ1dCBzY3NpX2hv
c3RfcHV0KCkgd2hpY2ggYWxyZWFkeSBjYWxsZWQgb25jZSBpbiBiZWxvdyBjaGFpbnM6DQoNCnNy
cF9yZW1vdmVfb25lKCkNCiDCoC0+IHNycF9xdWV1ZV9yZW1vdmVfd29yaygpDQogwqAgwqAgLT4g
c3JwX3JlbW92ZV90YXJnZXQoKQ0KIMKgwqDCoMKgwqDCoCAtPiBzY3NpX3JlbW92ZV9ob3N0KCkN
CiDCoCDCoMKgIMKgIC0+IHNjc2lfaG9zdF9wdXQoKQ0KDQp0aGF0IG1lYW5zIHNjc2lfaG9zdF9k
ZXYgaXMgc3RpbGwgcmVmZXJlbmNlZCBieSBvdGhlciBjb21wb25lbnRzIHRoYXQgd2UgaGF2ZSB0
byBub3RpZnkuDQoNCg0KPg0KPj4gSXMgY2FsbGluZyBnZXRfZGV2aWNlKCkgYW5kIHB1dF9kZXZp
Y2UoKSBvbiB0aGUgc3RydWN0IGliX2RldmljZSBhbg0KPj4gYWNjZXB0YWJsZSB3YXkgdG8gZml4
IHRoaXM/DQo+IEFzIEkgc2FpZCwgSSBkb24ndCB1bmRlcnN0YW5kIGF0IGFsbCBob3cgdGhpcyB3
b3Jrcy4gZ2V0X2RldmljZSgpIGRvZXMNCj4gbm90IHByZXZlbnQgc3JwX3JlbW92ZV9vbmUoKSBm
cm9tIGJlaW5nIGNhbGxlZC4NCkkgb3JpZ2luYWxseSB0aG91Z2h0IHRoYXQgc3JwX3JlbW92ZV9v
bmUgd2FzIGNhbGxlZCBmcm9tIHB1dF9kZXZpY2UoaWJkZXYpICzCoCBzbyBpbmNyZWFzZSBpdHMg
cmVmX2NvdW50IGNhbiBhdm9pZCBpdCBiZWluZyByZWxlYXNlZCBlYXJseS4NCg0KDQpUaGFua3MN
ClpoaWppYW4NCg0KDQoNCj4gSmFzb24NCg==
