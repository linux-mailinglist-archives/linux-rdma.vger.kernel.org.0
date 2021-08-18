Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10A43EFE36
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhHRHwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 03:52:01 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:49453 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237962AbhHRHwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 03:52:00 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Aug 2021 03:52:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629273087; x=1660809087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L7pWAWxR3a+xDGo9R3wcbjAZNbjAl185g/xJ3ChoA5A=;
  b=LrT810mZ/HpAFGbwn0KrKjaIvyZARKaGPGXA1heZ/XwxufcnhoxyucM8
   2qc4Dg4dD0IB9Nb56rHM6iKhLarmDMDRx/CsJrZBsVrVyiCaphDysrfZm
   UAW/Z6Ps2aURqf3t0euqkk0GLckY9z7faDVlEQlxiWORE9rtTWDEGnBPZ
   3o37UxTeNRy+RYDDoEaEPjrDgJB5UkAbFnlHwbpKd+U4MyCv1fTtQQj6Z
   zkeuPbJMqJ+UT543zkcFnjQMcl1FRB+E1kqmvd0qOeJiJypAXdxxF6NGd
   jCgPiUCKzA2w6/2nHlDCyKvCsn2Ooi8WIT3HGXtFJ+B1GC0JFuML48eio
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="45059103"
X-IronPort-AV: E=Sophos;i="5.84,330,1620658800"; 
   d="scan'208";a="45059103"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 16:44:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FERZOyjvuo9p5QFx4mYrUV6jBgAz3nXJSo+g9h2JDKz7QtDWJ0+iLYIehjSurrCyu5s6I/FKR11CbVHk3sIjEQUashnHs1A4dmrXXvya+KAh9G7dM/tzuRHavCZJZYOCr861EUblONv9e736htE9qy9hhoooHNS43jNeyB32WdlcJFAf0DiU2+LdrNVDLpkx1EKNbed+QlCqXuQsf593NPjhP3qyh2zKQzyauh7NvZa/zuIzpMGqocxLLuE8hJrDUvyuwlid6qj+oL1pzh7isU2RBxvcX5zDTDoSsUyxgNU8hdFsxEPWQW2tNe57NLMlWwm6GJyHxHW7vVTMFeqg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7pWAWxR3a+xDGo9R3wcbjAZNbjAl185g/xJ3ChoA5A=;
 b=O/80uua/kjXn0h2BrgMAdaO9BfdyPuHv+piQeiN4kGIz1/YjrDPoyn+1BKz5s8lC9qkTQf1Jaek48UuiWmjRgHBTf/ZcPmvRZz02jeLMOKw09sKKQ8RFLKgHUvF51EmCBeIqOveMwnbKYFRGhppf50YLPzjTKfCQ2L/h8Jbp3rnbWqMAHIVo5xq3aFlgE6zwWBOXI5TuXJUAsV9U67PSZIz/F4sfR2FUnyh0QZJYQ67E64h48MXcD2V1SKG4y2NweHzM9Gak9AWXnLpB6EcZEuLMzQIBjejN6uYmwKRPrEDyNt8lmblI1VSkCJEVrl8gJcXOWvj1M+1fNxehchhnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7pWAWxR3a+xDGo9R3wcbjAZNbjAl185g/xJ3ChoA5A=;
 b=JG/JZ/c8ctjAznKz9gSpQIdshRGJyam4hYVYjD+Gon+YyCIjXMr9d3ibynY23vBGkm/W/LfxZ7noJLiDggKXEh9MLSolHVBkNcjPNYXF3F8/kLy4+JouZ7r5suqqy/Ahz0A0BubJTvqHJXX8ZAmckxqgHevm49Y/Nv0hCwPyrpc=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSBPR01MB3463.jpnprd01.prod.outlook.com (2603:1096:604:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Wed, 18 Aug
 2021 07:44:12 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::90df:e87c:a4b2:b86e%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 07:44:12 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Olga Kornievskaia <aglo@umich.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RXE status in the upstream rping using rxe
Thread-Topic: RXE status in the upstream rping using rxe
Thread-Index: AQHXiJKFs2Uwv9tDRE2C9sy1eEMhGKtih4KAgAACJ4CAAEvmAIAAOPAAgAK4PQCAEUcwAIAB2XAAgAAKroCAAAZwAA==
Date:   Wed, 18 Aug 2021 07:44:12 +0000
Message-ID: <611CBA42.9020002@fujitsu.com>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
 <YQoogK7uWCLHUzcs@unreal>
 <CAD=hENcnUd-rTHGPq2DjyF7tDHVzCebDO2gtwZa9pw0M_QvaPA@mail.gmail.com>
 <CAN-5tyG4kBYBEaCDPGr=gUTNGkcoznMUy8e4BwCzWZkSPG-=+Q@mail.gmail.com>
 <CAD=hENdqho3mRy=gUSE-vuXzLvZPkwJ7kEFrjRN-AxLwvQP18Q@mail.gmail.com>
 <611CABE6.3010700@fujitsu.com>
 <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
In-Reply-To: <CAD=hENezpPKyGFVB121fjhhniE02fwspULi5vaScU1dWcbY7gA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec0604f0-72e4-4ffd-a46e-08d9621bf893
x-ms-traffictypediagnostic: OSBPR01MB3463:
x-microsoft-antispam-prvs: <OSBPR01MB3463515B9E497A36ABB90C4883FF9@OSBPR01MB3463.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wkZMRfS+/KZ8b/Q1/0dkNYiFYdIn4/e4lFyWRO0tL4sSMOinL46NBGUnbGydjl00BtR/fogGEPwcvv/WgO5g8pAFkl6RLvxGZYMTDtXEH/WgH4TiroygRTAdY1MWtAcFk7aPB6pDCJwBY1l1KdeBj+ForRXxHw8RsdnHYUnfbb2DsmHv3k8/fACZ5YGGGKrSOW2T2MrazlX71IVzDFyLbotlzTYX6Hl+HEH1Mt20QUmjLIaK0BcToMIspnJtepfRGeKbWsf64Xsskd4Qy16kkUqBb5WWsTVL6fh+osV/BsvKaZto82x2UdDh7vRjweiArvSLbe2JCGL4RMebd/ElbLSxHyGlQjgU36lGg1IJWawDOSc9+XvquhJN+GOH5BLUQjW4PH9FUuo+8rTrxewMaLWrbHTMqRpFnMr06c/hQAr7BS8cY8/9JrOhrESgKQYbfp89kry7ON/pxXxFL9L9lfVb6ewOCL3IeJylSc+xY81BViJuU/MX6xW1mdujxyLJ5ZjBs8+zMBER4D26KOrj+kft3B/VVWNVV3ZR2YWIIdcLW8043Lw+F7oPdnEbtc6BDsd2GQztXYc1uvkmS45+OaqX6H3IMtXpuDJDeLbhxw8OTZtKQmNsYnqrdStb3YJfabKvwpFNlk92OFrUh5bVUeaUBSzQ49yKlAxIWTrrRK+6/gmK4cq76p6FxFETfaZDfb7IZzcQfDEHf8m9L8AKow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(5660300002)(316002)(66446008)(8676002)(66556008)(33656002)(6916009)(66946007)(8936002)(54906003)(71200400001)(4744005)(38070700005)(66476007)(64756008)(76116006)(91956017)(85182001)(86362001)(122000001)(38100700002)(2616005)(6512007)(4326008)(186003)(87266011)(478600001)(36756003)(6486002)(6506007)(53546011)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzNidGUwS0V6QS9YZGxJMEI2bUdYYVRWYVlRV3hYSGVDVHpaR0dESHBpNzZv?=
 =?utf-8?B?eERqbUJSSU5GQU93SGVTNDNQWXRBaW5JVGlFc1pLVnZVZ0JEUGZRdU5semJP?=
 =?utf-8?B?WGd1WjlhRnBtZVc5cENyYzArZmh1Ykl1WnNrcFhwWkdmbURSYkpKdkgwbytq?=
 =?utf-8?B?NmdLRTJCN1V0QnYzeGRUMEZRQ2ZpRWxibzFPMXlkYkVxV3lSOUc4SHdSR2VV?=
 =?utf-8?B?R3FLR3lFQWo5MlhWQ2tSVUkrbk1wdi9tZjRjTTVmTHNwcUF1Z2tWN0VvVUJx?=
 =?utf-8?B?a3RvcEJiSW1LK3pVeU96UXVUNjVScUkwSVFBNEF6dzdHOUxoeDZVWEhhZmhp?=
 =?utf-8?B?cGZVb1dHRElrZlhNSEh5S2ZRQ1JyVnhqc3pkNjQwMWlUN25yWDJCNHpyMEkr?=
 =?utf-8?B?SFFCekVQcHFTTyt4QWVacEZEN2RrWlQ2dmVWZjlqK1E2SmVoak5QOVpkb1hK?=
 =?utf-8?B?a0VTOFRSTWtDR0NtWGJDTTdpeVZBMmppdDBhcHQ3ejVMQStmUTFoNFY2TXBk?=
 =?utf-8?B?TWFSeGwweGZWWVJHcnJIcFY0U1NvN28rbEQ4OGs4aUI5K3lONDFQOFBpWlI1?=
 =?utf-8?B?dEpGSWVmYnNrMzF3WXB2QU9SZWFSU3FBQVcwUHVrbkhXRVdqdmNrVjNPUUIz?=
 =?utf-8?B?WGpOVytuMVREME5GU0lXMjRrZnFXazVxSzdhclVsdTBGQmJoZlVaQ2RHVHpN?=
 =?utf-8?B?a2s1N3JOSTJ1SjM0bGRETDlxMExBVWcrSlB1SFFEdHpPVnZYMkZZK1BtZFM1?=
 =?utf-8?B?TmRwRk9UOHpiWmtqOXZXVFJxUTdmdXhFell5VUx5UjQ4cC9VZEhCTUpiWWUy?=
 =?utf-8?B?bmJjU1lpNE5qdUcxRHlGQnMyZ293N3lLSGxkV1ZISnpBN2labWFVM3JqR2Zm?=
 =?utf-8?B?bG5vcUg4UmNSSmFIclRzUjlpb3FKNzREeXlndlIrL2Jvb1g0TWoyVVVESjNa?=
 =?utf-8?B?TDdkcTM1UjdXbmJDbHh1alMxUS84cDNNTCtXNWdCZnNCTkhpeXNvRkt6L09E?=
 =?utf-8?B?c2sxTVVCczBZRHoyNXVTZlFxd3h1VmY4R094VE55aFNIcUp4WGNYV1RkTGth?=
 =?utf-8?B?dU5iTElybTUxS3JNY0FqZHh1bHI0b2VYNCszODlyb1l3VFRyYVZ4Vjg4Tnk0?=
 =?utf-8?B?aUJrb3hGOHQ4enRvT05MOTFCNVdOaFZMa3N6a3p2YUEyZmlDRHF1ditIRTBx?=
 =?utf-8?B?U3ZtaXJLd1FpU1BKbDFhdEtHUTBRYmhvOTZCWjAySi9RR05aUjFKNCtiVXdF?=
 =?utf-8?B?NzBjVkZsQktGeHdMQU5vbmtCZ3FCSzlnckJvNk14WVFjZkZSTW1VbTdYN1VO?=
 =?utf-8?B?RnlrbXJQNTdNTG4wN0U0elAvOXE3OUdic2F4aUVpdE93UGoweWRuWkdXSWNm?=
 =?utf-8?B?VElhRFY2dVBhV0RjN2llc0FGYlJlRU5VNzBkNEtWeFpLZkpsVENONG9Fb3BC?=
 =?utf-8?B?cGRWdDRIR2ZvVXNoalRya1F4Sm5KQkNBc1RrQlh1UnNIM3B6bjF1RnFjUWxL?=
 =?utf-8?B?Yk5KOUNiMHdxRTRkb2VMQjF1VUtrajNMMFZuV1VqdHMzWHlqQlltT0plNmJj?=
 =?utf-8?B?RXk3cUYyZUovODVZcXZQRlRYYmZYdzlIblJwdjhEaXZ5V1JPUHZtLzdLaW52?=
 =?utf-8?B?V2V2UGkrdkx0L3cvWUp6bC9HMU5ZRDJiU1dmTG1heVR5K29wS1ovZTlxeHBl?=
 =?utf-8?B?TmQ5M3JHcGFJRzFRZTU5dG44d29Sc1o0TmwxTXIrUUM4UXBqUFR6SkdiTzdI?=
 =?utf-8?B?V3gzMWVzZGdhL1NFNSs1UmhTQVlqdTdmbzhxblBnVjhTZmNlWEw5bllTaVpm?=
 =?utf-8?B?Qis2WGhHM25NazFhM2h6UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1939878F19EC6458ECDB97379B27FDC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0604f0-72e4-4ffd-a46e-08d9621bf893
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 07:44:12.3162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/MLCZapiZDwBNmKrJYoPY8WLdbKlQ8H7VgjMLPpUEaHzLXncOOKd06iPjJB0zfRoaIgunqsZr+JombsV537qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3463
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzE4IDE1OjIwLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBDYW4geW91IGxldCBtZSBr
bm93IGhvdyB0byByZXByb2R1Y2UgdGhlIHBhbmljPw0KPg0KPiAxLiBsaW51eCB1cHN0cmVhbTwg
IC0tLS1ycGluZy0tLS0+ICBsaW51eCB1cHN0cmVhbT8NCnJkbWFfY2xpZW50IG9uIHY1LjEzPCAg
LS0tPiAgcmRtYV9zZXJ2ZXIgb24gdXBzdHJlYW0ga2VybmVsLg0KDQo+IDIuIGp1c3QgcnVuIHJw
aW5nPw0KUnVubmluZyByZG1hX2NsaWVudCBvbiB2NS4xMyBhbmQgcmRtYV9zZXJ2ZXIgb24gdXBz
dHJlYW0gY2FuIHJlcHJvZHVjZSANCnRoZSBpc3N1ZS4NCg0KTm90ZTogcnVubmluZyBycGluZyBj
YW4gcmVwcm9kdWNlIHRoZSBpc3N1ZSBhcyB3ZWxsLg0KPiAzLiBob3cgZG8geW91IGNyZWF0ZSBy
eGU/IHdpdGggcmRtYSBsaW5rIG9yIHJ4ZV9jZmc/DQpyZG1hIGxpbmsgYWRkDQo+IDQuIGRvIHlv
dSBtYWtlIG90aGVyIG9wZXJhdGlvbnM/DQpObw0KPiA1LiBvdGhlciBvcGVyYXRpb25zPw0KTm8N
Cj4gVGhhbmtzLg0KPiBaaHUgWWFuanVuDQo+DQo=
