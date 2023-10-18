Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6207CD3EE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Oct 2023 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjJRGO5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Oct 2023 02:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJRGO4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Oct 2023 02:14:56 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89199EA
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697609694; x=1729145694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YuGTXJcjrZuPCxGJpAYOdQthB2UgQ/nhrJp1hgAhVJc=;
  b=Tzdit7LXRld+0y9ZLA09Sb/SMJagxmSv+fhjoHp8uZCB7th2jpXWLcu8
   qigwyytxt9yCtNQameKeQ4lQQc3NrxJpdLNRaAkTJA3zScFXXbvBBEuaa
   o8Vum08vtqcGLE8ojSFFE3JARjQ4r82MK3pPjva0PWDqQRmJs4pT7RMW9
   hLTbrcQgYZiDoCCcUm2f115vuXE8MFGZ5HWY4ak5kzfZRF6BzVyLY/U70
   lJV5hh9KEuLd6+aRAceasFr9OX9DPmWra72YWT+kuA84pU4otP8Wnc3hU
   sZH462qUsEHJELWq+HXwmy5potfqipnNf1+4B676xsvVG2ANZ/4qQirRy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="99948617"
X-IronPort-AV: E=Sophos;i="6.03,234,1694703600"; 
   d="scan'208";a="99948617"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:14:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0FqyyNqzvWPFOKrWXaaOAtFkp96N/okZWAsVKqR46hs5+TOWe6iep54fofOxTuRIH7N6l11Giputit/3GDOFIV+/FejxYnZvlTH8kizMXHYuw49vKJRx+oS06/NhNKs+yU8b2n8crDGennnjBshIzkUzns5viAIgGC+lkIhiXYCk/xG/OhexxKRpy7+dUv06YON8OxSeZ+Tdn5JahrLjxVm1L3yegAceUbDbmvEYGDlWoWnz5FKTCia7w01PIDAj5kgHigB3PDAaBiBXun8sfaoKUc5i7KsHfE5BtpvNMURxQKYAxcei/33VlwMJdiUK11wmYPJV+17bnoehxvE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuGTXJcjrZuPCxGJpAYOdQthB2UgQ/nhrJp1hgAhVJc=;
 b=U9HSfgsCLuN1KWna6Sk4rfReNkfEe3DTWeFy+VXIm0Y1JE19F0B/xGPxsEKYZOBaMNzo01g4ncrI3ffbieQp/5nIRzDOqrlFOMws9iLjcN2aeMbSVbq4Wzo0v8nKrI/5E8+92XZweMJxP+EJl+i2+j8j+0lrJzUwHG4RUwDJNkjbSqyjKuoioCl7jo32pL93zjsMZ8lidqUmu8hePeFNVvtWX4t6/mr5K2c21cJtDBo8jxFZybEnD1X+6KtJTGdlsFAezBHvN/KMd/fIQl+q/g0xn2uqwyBV+3T2kqMNExRKA3qMRd3SE+YGGrudobIsPqEuth1Q5VdJofpjtncajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB8238.jpnprd01.prod.outlook.com (2603:1096:400:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 06:14:48 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 06:14:48 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno on
 failure
Thread-Topic: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno on
 failure
Thread-Index: AQHaALwOG9DiWyvgHUuLIo7t+ThLO7BNnvS/gAEfmICAADvdeYAAGOcA
Date:   Wed, 18 Oct 2023 06:14:48 +0000
Message-ID: <209ca19d-b5d6-461a-a00f-9000459159cc@fujitsu.com>
References: <20231017053738.226069-1-lizhijian@fujitsu.com>
 <874jipd6e2.fsf@pond.sub.org>
 <c6f747e3-7e2a-41de-8ff4-63e00bbf1de8@fujitsu.com>
 <875y3435eu.fsf@pond.sub.org>
In-Reply-To: <875y3435eu.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB8238:EE_
x-ms-office365-filtering-correlation-id: 44a3338c-d669-4233-9e4d-08dbcfa18807
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udEmBlsWtOL8hflLyTMbgrsgEtI3124dRuG0KNW4ndVYfhX4pDlijF4QWWPqqadasJw+s1fa72uasEqgHeVZDESrFyBEH6BmXkWNDwS0GiW6laI4qeFd8MEmfvimgFecYDHyDQ0/Dd1nPuFfoYNKLvt/v6yteYmGZdCavm3JJtTLmQtFZAWvcXFFKxjF8DAt1neTC4QIabbFSlnaWtewCy1NHD33M9We8typrzfTQkAeTvFjzdFzKL0P7txS5/fJ5AMgZCuFfFPmq1WI1zS0rkBzyWygwbINiKU2KzuB+vptMr4mouoJMIgeD1bYACOtyk1TXkDCQ89OnrlUIgGTRwE/JLwzMmvjyVvea9FVwfvRddoLoPh9l7I6EMm3w+WXDlSAhSci6hk61SHHdDRpwsYMETAMSrgCOWY+WqRtpe/O0rWp7LclXhGrpLnpAzlzHrqeUlkDxslHEK6VwEsEP2W2QB8786S/JgDPR8y1xjCN0n9rb4VDoxmlOlWDvCbD8k4SrTCx31mhrsJojQ6AXfIyMDOVNvbKvm7r/GMc3egds8fIHHJvr7StWLjcvLQCK5fcxSwfyO18SYgOnWjoPlbBAhc9QSAGMLntjZRK38jOsglJE6Jv4NDMVMXEVpyYLY9oy66WqkTAP5HJ38P1Ud8aAr3X2L3fuAbA7Aro05ejy7fcttm4YyDmmMOG/eWuT7frwBY5pXFKLyXSpWIMsikziFuEZz467Sl44uznWDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(1590799021)(1800799009)(451199024)(36756003)(85182001)(31686004)(1580799018)(66446008)(91956017)(54906003)(66476007)(64756008)(6916009)(316002)(76116006)(66946007)(38100700002)(31696002)(86362001)(122000001)(82960400001)(66556008)(38070700005)(53546011)(83380400001)(2616005)(26005)(6512007)(71200400001)(6506007)(6486002)(8936002)(2906002)(478600001)(966005)(5660300002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1PbVV6NU5lRmIyMXNDVEFpNWtoRUNJSndJT1JOQlZ1UGlxcEtKSDQ5Q1dv?=
 =?utf-8?B?QmNQQy9aUG5nVFpaK25KaUpPNTdvdE83UE9wY3hucXk0Zzl4c0l6L09MRHRu?=
 =?utf-8?B?YTFicTk2TVRRS2xRb3FQSE1mTmtzeUpYempNV0tYb2N0bW5MNEJyTHZrUXN3?=
 =?utf-8?B?b2Z3dTZTVy9tTEtsT2xwT1lKWlE4VVM5RG1GT2dNWXRXbVNZU2hxNlYzUXA5?=
 =?utf-8?B?UEVDNTQrWlpyRzMrNkxXYW43bmVGUThjamFkaUNHMmE1MFBOdjNxZjJ3K1F0?=
 =?utf-8?B?ZlNLeHJvNXh0dkxaSUxWWkwyR3kvTDhaRm1SZ0NYTVQxVjYxQVJRSStUd3do?=
 =?utf-8?B?ZEk3UXVDQW80M0xkREwrdzdTdHF6dzA1akVER1I5QnEwS01XVGlKT3dQK05C?=
 =?utf-8?B?Wk1obzM3Mm9BUlZZdWZsS0dLM0tKSGxCNC9KN29DS2dBTFI2Qlo0OFZ0amN3?=
 =?utf-8?B?ZlVqL2dnajY1YVo3ZENJWm9YVVoxbWR0cmx3UWYxSS9JS3NxbEVrTzZHVndL?=
 =?utf-8?B?WnlyTG1Fd01FMHd5bGpCd2JJUVA4dnQxZUlBQ1RUZFN4UnZHcVZmVStONjdZ?=
 =?utf-8?B?YUt6OTNxZlJselJwYWhiOVJmM2pYT3BxVDNrazhseVJlVXlGQzRUYTgvdytM?=
 =?utf-8?B?Q0NFbkw2Z0t4Z0E1dzVkMjRid2FSekR4OXdReDJzUm94dXBOZk9YRm4rcUdu?=
 =?utf-8?B?ZWJuc1lTK0x0QStmYjRDVC9ka3p0MWJlYktIUG5QdU45eFVVYURVNHkwY3ZS?=
 =?utf-8?B?VHlydzJJVlU2VEhRQTh3RlZIWmE1eHFRbjdkZkVKZFFuWFpHeWRyb0trd21G?=
 =?utf-8?B?bkZRdjAwZ0hwa3grTWZCbWQ3SHBOb3h6RG5xUUpUSW9ORWVKSTduWi9mbXBm?=
 =?utf-8?B?TkJuZ0RVWlJKVnpmN1lmTTlvcUxUc21RbEZOSzljaFRSUG5oQjJ6TEJMaUEz?=
 =?utf-8?B?bzUrMlphOE1wRHM2M2RYT21taFYydGFzSGtqWVpmT0ZzRXpLeWo0MTZsVVRI?=
 =?utf-8?B?SzVYdFlESmNDUUVPdWpncnk4My9CV2NiZEV2TVdOOHdCTTRkSURrQWpDb04w?=
 =?utf-8?B?dzdGTUxId3FmZ2ppOCtrNkY0Nk1YNHAycjlLbG5NWWYzM0Ezdm1wK3pzUEtx?=
 =?utf-8?B?Tm43UFZaanRrZHpvL0I4UW13MHRuaDUwYjZtTjNmeDJHblhkcW0vVFd0MEdC?=
 =?utf-8?B?bURlVVc1akhXbmN1Rnp0aDVFbytEL1ZtL3NPdERiYjNrK0JTTlFJc0t4ZXVl?=
 =?utf-8?B?eFdBeFBmaWREdEpXYWswdm5pK0RhbGVWdEpkRWxCZEw5NVRRVkJlS2g5YStC?=
 =?utf-8?B?SVV6RnlWaGFJQ3k4M1ZLN3VhWTlseDJFL1hVaG1UQjM4bnowbGttQStzZjBJ?=
 =?utf-8?B?azhnVmpnb2JYR0g5N3d4eHNZRHZnMXJ5ZEh2YXNMMkVhQUJKNTkyYlB5WFN3?=
 =?utf-8?B?ZlBnSFJYS3RSMm9Yb2dES1hFbGw3bnZCTXBlSkRyMVhXT29IbjBkNXdZK3Q3?=
 =?utf-8?B?WW1rWXpyaW9TVjBjQi9iYWVURC94S2FnN1A0a2dqWUd0WGV2aGw1MElQdFFq?=
 =?utf-8?B?dndiMFcyeVdtT3J0R3BNSU5EWm1YRnd2YzNjQWhwRUJPWHhIT1NmeWhkZW51?=
 =?utf-8?B?N0IzNk0yOXN4QW4zd0NRQUlIdzNIZTJacndJeDlISkhPUEphVUpsTlZ5dlN5?=
 =?utf-8?B?QzFXSVZTQjA2RnNHOEJGai9FT0M4OGtGY3lqV2VXNmhabFhJUEFDQk1lTlVJ?=
 =?utf-8?B?WS9TNE5LZ2FHRWFRa2tIWmpYb2lSd0tkTWtaTnNwYndSQzJhR2F3dm5DU2tw?=
 =?utf-8?B?Yk1ra2ZrcDlRWnpORnV5YUJ4ZGo5RXIzcEpXWElTSnhhV1NZUnA2eWphblln?=
 =?utf-8?B?aFlhUlE0NlBUMXQ0QnpHMUs2QlFXUmdQRHEzN1dKaHA1akFscmNydERscStI?=
 =?utf-8?B?VkVxUFA5SG1WVEVZald0aFRCU0RhdHBER0dRb01nczlRZU1BYW9BeHdBTHEr?=
 =?utf-8?B?OWRDd3RxRlV6UU1IeklSMllNcUIrNkpEb1dxc3JmUURqZ1lrdlhHMlhIdWdT?=
 =?utf-8?B?TkE5WWNCZmdzbjhqbFlSMlZPZWExTnVVYjBUZU51Y1pvSS9XRzRWRDFETitL?=
 =?utf-8?B?aTFXZjR3TEdmdzZvN1VpbGEyUUxaMlF2dEdSOHNLWG5VOWRjcEJJTnNadXhY?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EE119B50E8D954289BD1C32F90594A4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XNxPKJmNaUfNmduIdhPqulAIj2E6EATg0nra+geDK9UmSUkIIgDW1qny4Z2Ne3WrznXcl7C3sbw5fyrChgP641t24APzKPdFNhZCKMYLj25+Az1oROpd05Ge0V76HoiAXiC9EP8UeeVkXLcs+AEfhxwhkp/466SVWvVOLnfEVAcYtRBKVo+NRW0na7jKMcLW7/Yms+X75sHfb0qqdPZ6MtnxcHjQGEzWwsTYd8bqeUkITH/p4bp/ivcGPXRoDxT/BOE8cXtHkkXvlNrFXLm/7G6qye+shQ6KZAzMmVLGOU2fyiGyJg/M9NNOgXz1axZAyhFCQdMy7LL6lsTy1dfVV9MZseT1bt5reY7qvUCbI1PNvJwq6oEjRu4kAN5VkubQR+bP+4oApIm/qFyUx5XDAbqscUzvki/DUYhz8FeOAt8gyth4ixAImBWkW22QUYey1c5yHF8JY0foYqtj+ttyDLSuas7l/cLd2kXmn/GUJrOBroTiucUxFQsVRZSkRYAmGOQcHBdZGhYPPs8K+DazdQXzv/4/YnOjRjDNFxdhPeawGycOin2/QhB5goaHgTNiy4ZPkohVzs7ViPbPfgP9YaXDd8gQWbSZs0T6lKwKXh+5yflrYcyXw1xigAYN9jx1wlRMgGNETm/jWEXxswMtMKiSbd5tkJslhdT9TTa93jG9KimdeKki5c5yDYrrBDcz18WMOqZ6dyFm/d3ELUvChgXoTWgWIjOrEF46yU85SWpCDQEaNNgWeS1IjogSkH3eKgtO3EsTtXoZzbiyr6jgXH5Xm1adoRRVsoi6W7vazjv2omlEsU1Q2vRZJqCPEMY3z2yqtq2KwbTXtAQ/I3V68A==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a3338c-d669-4233-9e4d-08dbcfa18807
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 06:14:48.1885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHpYSekzFrG87Z9lpPL3FEhRBctNuw8kaU8Ag9Bsi+zfdU3rSiCTSFVMveGmHbu0/0PlQTgwMnYnCUnFB09N3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE4LzEwLzIwMjMgMTI6NDUsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxNy8xMC8yMDIzIDE2OjAxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBMaSBa
aGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiAnZXJybm8n
IGlzIGJlaW5nIHdpZGVseSB1c2VkIGJ5IGFwcGxpY2F0aW9ucyB3aGVuIGlidl9yZWdfbXIgcmV0
dXJucyBOVUxMLg0KPj4+PiBUaGV5IGFsbCBiZWxpZXZlIGVycm5vIGluZGljYXRlcyB0aGUgZXJy
b3Igb24gZmFpbHVyZSwgc28gbGV0J3MgZG9jdW1lbnQNCj4+Pj4gaXQgZXhwbGljaXRseS4NCj4+
Pg0KPj4+IFNpbWlsYXIgaXNzdWUgd2l0aCBpYnZfb3Blbl9kZXZpY2UoKSAuICBQb3NzaWJseSBt
b3JlLg0KPj4NCj4+IFlvdSBhcmUgcmlnaHQsIGlidl9vcGVuX2RldmljZSgpJ3MgY2FsbCBjaGFp
bnMgYXJlIG1vcmUgY29tcGxpY2F0ZWQsDQo+PiBJIGhhdmUgbm90IGZpZ3VyZWQgb3V0IGlmIGl0
IG91Z2h0IHRvIHNldCBlcnJubyB0aG91Z2ggUUVNVSByZWxpZXMgb24gaXQuDQo+IA0KPiBJIHRo
aW5rIGEgcXVlc3Rpb24gdG8gYW5zd2VyIGlzIGZvciB3aGF0IHB1cnBvc2VzIGNhbGxlcnMgbmVl
ZCBlcnJuby4NCj4gDQo+IFRoZSBvbmx5IGNhbGxlcnMgSSBrbm93IGFyZSBpbiBRRU1VLiAgVGhl
cmUgYXJlIHRocmVlOg0KPiANCj4gKiBxZW11X3JkbWFfcmVnX3dob2xlX3JhbV9ibG9ja3MoKSBh
bmQgcWVtdV9yZG1hX3JlZ2lzdGVyX2FuZF9nZXRfa2V5cygpDQo+IA0KPiAgICBXaGVuIGlidl9y
ZWdfbXIoKSBmYWlscywgbWF5YmUgdHJ5IGFnYWluIHdpdGggSUJWX0FDQ0VTU19PTl9ERU1BTkQN
Cj4gICAgYWRkZWQgdG8gdGhlIHByb3RlY3Rpb24gYXR0cmlidXRlcy4NCj4gDQo+ICAgICJNYXli
ZSI6IGlmIGVycm5vIGlzIEVOT1RTVVAsIGFuZCBpYnZfcXVlcnlfZGV2aWNlX2V4KCkgcmVwb3J0
cw0KPiAgICBJQlZfT0RQX1NVUFBPUlQuDQoNCmxpYnJwbWFbMV0gaXMgYW5vdGhlciBwcm9qZWN0
IHRoYXQgcmVnaXN0ZXJzIE9EUCBNUiBsaWtlIHRoaXMuDQpodHRwczovL2dpdGh1Yi5jb20vcG1l
bS9ycG1hL2Jsb2IvZjUyYzAwZDE4ODIxYWM1NzNhNzFlOWYyM2E2ZDJlODY5NTA4NmU5NS9zcmMv
cGVlci5jI0wyNzcNCmlidl9yZWdfbXIoKSB3aWxsIGV2b2x2ZSB0byBrZXJuZWwgdmlhIGlvY3Rs
KCkgZ2VuZXJhbGx5LCB0aGUgd2hlbiB0aGUgbGliYyB3cmFwcGVyIHdpbGwgc2V0IHRoZSBlcnJu
by4NCg0KDQo+IA0KPiAqIHFlbXVfcmRtYV9icm9rZW5faXB2Nl9rZXJuZWwoKQ0KPiANCj4gICAg
VGhpcyBmdW5jdGlvbiBhcHBlYXJzIHRvIHByb2JlIHRoZSBkZXZpY2VzIHJldHVybmVkIGJ5DQo+
ICAgIGlidl9nZXRfZGV2aWNlX2xpc3QoKS4NCj4gDQo+ICAgIEZvciBlYWNoIGRldmljZSBpbiB0
aGUgbGlzdCwgaW4gb3JkZXI6IHRyeSB0byBpYnZfb3Blbl9kZXZpY2UoKS4gIElmDQo+ICAgIGl0
IGZhaWxzOiBpZ25vcmUgdGhlIGRldmljZSBpZiBlcnJubyBpcyBFUEVSTSwgZWxzZSByZXR1cm4g
ZmFpbHVyZS4NCg0KRFBESyByZWFkIHRoZSBlcnJubyBhZnRlciBjYWxsaW5nIGlidl9vcGVuX2Rl
dmljZSgpWzJdIGFuZCBpYnZfZ2V0X2RldmljZV9saXN0KClbM10NCg0KWzJdIGh0dHBzOi8vZ2l0
aHViLmNvbS9EUERLL2RwZGsvYmxvYi81Zjk0MjZiMDYxOGI3YzI4OTlmNGQxNDQ0NzY4ZjYyNzM5
ZGExYmNlL2RyaXZlcnMvbmV0L21seDQvbWx4NC5jI0w4MjkNClszXSBodHRwczovL2dpdGh1Yi5j
b20vRFBESy9kcGRrL2Jsb2IvNWY5NDI2YjA2MThiN2MyODk5ZjRkMTQ0NDc2OGY2MjczOWRhMWJj
ZS9kcml2ZXJzL25ldC9tbHg0L21seDQuYyNMODAyDQoNCkkgYWxzbyB0aGluayB0aGVzZSBBUElz
JyBpbnRlbnRpb24gYXJlIGdvaW5nIHRvIHVzZSB0aGUgZXJybm8gdG8gaW5kaWNhdGUgZXJyb3Ig
cmVhc29uLCBidXQgdGhleSBoYXZlbid0IGJlZW4gZG9uZSB5ZXQ/DQoNCg0KPiANCj4gSSdtIG5v
dCBmYW1pbGlhciB3aXRoIFJETUEsIGFuZCBJIGNhbid0IHNheSB3aGV0aGVyIGFueSBvZiB0aGlz
IG1ha2VzDQo+IHNlbnNlLg0KPiANCj4gSWYgaXQgZG9lc24ndCwgd2UgbmVlZCB0byB0YWxrIGFi
b3V0IHdoYXQgcHJvYmxlbSB0aGUgUUVNVSBjb2RlIGlzDQo+IHRyeWluZyB0byBzb2x2ZSwgYW5k
IGhvdyB0byBzb2x2ZSBpdCBwcm9wZXJseS4NCj4gDQo+IElmIGl0IGRvZXMsIHdlIGhhdmUgbGVn
aXRpbWF0ZSB1c2VzIG9mIGVycm5vLCBhbmQgd2UgbmVlZCB0byB0YWxrIGhvdyB0bw0KPiBtYWtl
IGVycm5vIHVzYWJsZSBzYWZlbHksIG9yIGVsc2UgaG93IHRvIHJlcGxhY2UgaXRzIHVzZSBpbiBR
RU1VLg0KPiA=
