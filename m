Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2875081BB
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiDTHLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 03:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359605AbiDTHLA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 03:11:00 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39934275C1
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650438494; x=1681974494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cAY7P6uejP/ktXxXl2rtDgo9q7+Uyu/cq4frKXUvOYs=;
  b=dJ5VhFXLCkbD0oL7Cj5RuZMXkAYjha9mjSHl5FD76wbMbNZmwYEpo9nX
   kQPRUGSpn6LdJ9LqYRUl+wZgQirkaQJNXu1SOvpRT+4xsHqbQxElTY+Xv
   z2bLIuuxY7fa4A0QfF5ZYtBg0uCGf384rx9A5YDZsB3+2GTZKpu5JJkfJ
   xxw58LKPyQbLYjr+f3tjqhagrg4l127yKYNeyTvLeLrHUk2jNvDZmP2jx
   3NeKLdR3X6LQVnaBWkM9mP/Nb2uFG250rYJX72sNKqrKKS5IalBSLHmOp
   XhyD0LjGS+T+vwkGmV73pXtfIQHkKuv/cPwu3skyTAaUuLoS5IzHenRcO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54243693"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="54243693"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:08:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ileDuYhRd8sxE6cX+ywebfklhfTypA2WOUFukzsjY+KRAHeEn1Slzn2oxhBAoEs8Z3o65rJngSrZpCI3/+u4cOPxWBACOoMTrBYnbO3n32ONpgQbpZGHVO9ynG7FAA2x46FrALUJkC0eQMM+Kz7w5pTiuuOVoMNzK0XQmUV9r6/jO9MT7lflOVcFlE69bZWROeQGGqYET5stNgmoovg5TQn05VFtoYkdyvBSmDmodwxLcn5DujE/1/+9cPQGqIT4lcD7Ucwpgnq3NKnLXnvAp1BmQZDP8VrhRoiVUMI36K+V1ZQKplX4fJYt0zeS3Y2gjgk88+Ix+9r35t73lAucIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAY7P6uejP/ktXxXl2rtDgo9q7+Uyu/cq4frKXUvOYs=;
 b=RLoHVVty6hJv06w31lqKhCzOC7OT9sDevqrT602Jgdb1pqfTm0J31W/SbX5bhoIrnbOxBiEAaTZTWVPcYxZT9NjFmHzPzi+NMG+H9hQzjzT2QcBipngudTOXKQFmT+FyUHXEWsTa4GkNF4BhCz9z2C4StH+l/HlJfnO5FQtqCnofQHGKKY5jN014twmsISum3uKK53JSaaaHNBOpVh+3/uStisoPIV/8hGorF+Vq3lFkHe07KlsC6ADPnt6/V23oNCdsPld74iQkorUQ0jjn/C8TjOrgdhKKBs07ehEz8LZQa+NNGr1sTtPgWoUd63tf4tXRAtPMrj2L7kytm5aPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAY7P6uejP/ktXxXl2rtDgo9q7+Uyu/cq4frKXUvOYs=;
 b=rOFHdQtHCHUKj1ngk3FoG/+QcK9NO/hHfDCnnculXraue8iMRDKNO3RplDtNKroRI2k31BE4grX5EVQfcn54sAJqJABAY+h5TwYn0ieu0yqVf9fgehZ34Yn329CK3go4BEz6B156r+++xi1l8d9fCHF7k3Jp05hzInk9wHuSz7w=
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com (2603:1096:400:99::12)
 by TY2PR01MB3499.jpnprd01.prod.outlook.com (2603:1096:404:cf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Wed, 20 Apr
 2022 07:08:07 +0000
Received: from TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::60d2:9261:f7b5:c56b]) by TYCPR01MB6382.jpnprd01.prod.outlook.com
 ([fe80::60d2:9261:f7b5:c56b%4]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 07:08:07 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYUutUn9XU4R6Jekm3O/NqdHUgQqz4YSUAgAADxgA=
Date:   Wed, 20 Apr 2022 07:08:07 +0000
Message-ID: <501aedc1-106b-10ed-7ae3-e54bef5fc2d8@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
 <Yl+uKqWp1pj2doGt@unreal>
In-Reply-To: <Yl+uKqWp1pj2doGt@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcf70685-c240-41c5-42c6-08da229c8560
x-ms-traffictypediagnostic: TY2PR01MB3499:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3499EF662B59FD36A42802B083F59@TY2PR01MB3499.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ed8n7kgAx3yHw/HV0uallq/KWl93v2SXxIuu4IWtR7PKkH6rfhTrhS6HDhZWpHWwVM3n59Vs0TDUoXEqdwc/EFIeI+r6uA4P5Yr43kgSVgqlCcYU7GBO0zikhf8dlfs3MQf9fYomzKvsUbaKhaCtGTtHSnSRnP9NXAb8dMdYCmi0ENPAZsfa695JkuEoOT783Sw1UOLqX6AYtHmq5XDs1xJiR5CZT3Fi+fCOk9DCDsZLrwWR9hB1JDZiJTMb8xbtP9AGfoFCP+4ExvK4QBuz2+SiZl3wW82QB/93sMijZNlNZ1/532qoPITWv+9lII5p7SilzfyIyeishepsklQ3+Sidqb5rNmwON5h81jiPHw5GYLRoOpUB+k61EvAxFHbGWXuU2HCfvQuIM1Ij8Zvyn6KT+pFdEOVceSQ9mi6lNVCo5FqEAe3ZYsLv0kbS+M16LTBZm0Wuo2TDCvDwzTp/uTpazsNtuj81BF+q4n0Xjs6LsghUFWIOVwPZHrfwF9T0JnnOwUAskdlzvQQTCrmnLfcSHYdhU7E4RqX6th8PmTzX/4boZq0vhGM1F1xsS2HVeUu7GoF68bRiKXgGppl+G646b28MmevY1JRH0rk8GY5oPJQ9GeDhmKS9iu34zeJ/yo2z+O5tQzB/6lg0B4mwJuc5UDnxjZmFsb/pVFrlxHpVeh6NKFTg9brN06pZzZGWatP+BdK3L2fgVkYGDp2ST6wDU50yueddkPGmlBHOch8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6382.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(83380400001)(2616005)(5660300002)(186003)(8936002)(2906002)(66446008)(36756003)(6486002)(85182001)(31686004)(8676002)(76116006)(31696002)(122000001)(91956017)(86362001)(64756008)(66476007)(66556008)(4326008)(6512007)(26005)(6916009)(38070700005)(54906003)(38100700002)(71200400001)(558084003)(66946007)(6506007)(82960400001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFY1eXNTWGozZUc1T202NVkyRlFIYjZORE1TUzVaME9tRnphc2w1TUozcnlx?=
 =?utf-8?B?cVhWMnpVcXZLb0RldUtUaVJ2TWNiU0xQTVEzTWdCcjNZZzZlaEFLbXl4b2RT?=
 =?utf-8?B?aWsxV1hXck9uQzlwVnJDVEZvYVFDSCtuaHFpZmMvV1ByZHlCVTNVYm9td1RH?=
 =?utf-8?B?M2xxdEMrajZTU0FCOUdlZXNYL0ZrWVRKWWRtWDhkQU00QStkNkNUNUZaOTZU?=
 =?utf-8?B?a3gxSnNzdFJwYjFQdHROVWt5aVEwYk5KS0t1WC95SU5WTlFJV2FGU1Q5RkJT?=
 =?utf-8?B?TmdDZnE1Z2pKdFRGS2xuQTF3R2dSNXM1VHhXWm9xSzVVNTNqUm1GWVdjM0gx?=
 =?utf-8?B?TXFPSE5LcmRzUUhWQnBjekE1S29Ya2pQN1NqSjI1SDg2cGVYTElGb0FMOEQz?=
 =?utf-8?B?M0VXMnB3SUVBUVJLRWdHL0NHNUpSMmVScm9YMzZVQVVlVjBmNWJGS05Jdy9K?=
 =?utf-8?B?Y1RiU0dMWG1kd3VHZHZxWnlETnBFcHpNdklEOUFCNGF2RU9mVFVPZVM1L0lY?=
 =?utf-8?B?dGFXdHpld1M0RUV5bW40dHI0RHVKUkpnL0xFeUFOZXVSTStVR21HZUVlaXFs?=
 =?utf-8?B?dDR1QUduUWEwMjNGRmp4cmM1NHVzUEY0QmpyeTdBZmU4WnQ5WjFkelQzUkFE?=
 =?utf-8?B?OW9SNHFOSXhMMEo3bDhOY0Q4OFhELzBaM21kY2RibmlWYWdzU3Y4b2l1NzNj?=
 =?utf-8?B?My9STG41WkJ5Tnk2a3gyenhHbzUyeVJWN25ORG1oMFI0bVQrOG5Wc2srUHBu?=
 =?utf-8?B?MnkzRVdYRmdnbzh1dDhLS3NwakpBNE50TSsreUk5b3JnbjQrd3VBY3VjTEZZ?=
 =?utf-8?B?dFRCdmlaQXNtcTlHNmpQb1VSdVp0WEo5VHl3bkFQNDY5Y1VLaC9ELzlFUFpo?=
 =?utf-8?B?MlVaMmRyZ2xkcERycXhQVHZKV0d6dVFSK0hBQjAzWE9yMGh1YzJXTlp6aWpY?=
 =?utf-8?B?RWIwK2FVK29jM05xZENGNTVxZ0Z0VTFONTBsVmEyblYrcFYrMldmRnYybFB1?=
 =?utf-8?B?VWtEM2hOdEVNc1Q5SHgvYVlrdVRMenNMcVRRYmtOUVNiTUNCajNyWXg2Y1JT?=
 =?utf-8?B?clZkUkduSGo1MmlROFNoM3JGM3BjWWVwdEx4bzVVbXdVYW0vT2lQVitZRXFR?=
 =?utf-8?B?QmVRYW52R2VBYnZkL1BrZEg4VmdkSTBpVW1YMkxXcUJtamJhcFM2UEhzTElk?=
 =?utf-8?B?YnpyN3NpaU9JR1VmaWQyNHhIRzFQOW9UV3JyMFNUaEZBSjNUbGQ1VGF2c2dy?=
 =?utf-8?B?UXM5c0E3enIybzJVRVN6eFBSRVRRVERXTjlYQUVhckxCbUk2eFVTSVRCd3RU?=
 =?utf-8?B?VFV2dkRHcDNGdUhRVTR2aWVaV0k3dUtvK1d1ZGF1RDFXUzd3eGpWQmtoQm1P?=
 =?utf-8?B?QVo3WW5kb3lVRjZuVzBoOCtudWVkVWFhWEYvTU9HbHhIMnpLQkhrbXR1ckpD?=
 =?utf-8?B?bmFRYm11Q2VvbzNwM05DdDdWbUZNSG1rY1ViM0lwQ1FkQzkyaG1MYXM3cXFs?=
 =?utf-8?B?a3drZkUwWDRSaXJDOFdLUGdHOFpjWVl2dVBDNytqeUpjK2FFRmNZdWc2U3NK?=
 =?utf-8?B?eGs3d2VzVWFsYXoydllvazh0T1Z6ekxLeFhqMGl3U1V2NTU1TVVFQVcyd3ZT?=
 =?utf-8?B?ejJvYStvVHZJc21zZFAxb3h1am9PM3V6d1ZIdDRTMWJHeXR6aVlxQlFKSkdx?=
 =?utf-8?B?M2FxWWZsYkZDdDBUTmZBb0FwZlZlclpDclNUNUdwYXd2bzlvaWlnOFEvdDdM?=
 =?utf-8?B?SFczKzNFY1RRY0g1cHgzVVBvOUo3eUxYcGpxVGgxM1p4d05rb2xYWEpyVGln?=
 =?utf-8?B?TXdtNk9JdXg4SXdCc3JvNThNZEdjbE5rTXJkOUo3L2hPdUZOSEJZd2k0bHJm?=
 =?utf-8?B?eXdIazFqekhnT09lMWpQTU4yL1p6UDBNTjNoM24rYWx5SldZbXpSM1RZMGM4?=
 =?utf-8?B?aUE5eHR3VVI5SnBWaExjb0Y1QUpQMTdLOG5vem9ZZDVER3lwZjVGdC9mU2dF?=
 =?utf-8?B?THUwRGpoZnZob3I5MHhzSysreFJRVWdXWXpKRHBwVzFQTTE3VmtjSS9Zdysv?=
 =?utf-8?B?UW8xQkFEWnVRVDYraDlsbjhQaHh2dkdORUgzVVVGQmVTTVV1L1hNZlo2MC8w?=
 =?utf-8?B?dGtEanZ1bWhrVllLYlp3UmMxT2t4WElrTG9WWitDbXVKUHgzOE9oQmgvR2hp?=
 =?utf-8?B?cG5JdnlXZTZvdjhmamJXSTJ1SktuZzN6UGZueTQwUzJLSmFYaXFRWHJRcUoz?=
 =?utf-8?B?TEhzYW43RW9ZKzBXVkNBU3ZSaXpYbFNDVVF6Wm10a2NLWjJWRUU2R0pCR1Vs?=
 =?utf-8?B?YldhL292eGtmMkhGR0ZxcFplY1A0TktEM3N5aVMrWmFRelZLeHM2UCtJTnRC?=
 =?utf-8?Q?wZjvPmulI1PhtNFs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A211CD4C8C553648B026C37E29F3D807@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6382.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf70685-c240-41c5-42c6-08da229c8560
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:08:07.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tukvyA8STf/YXF5cdocDBTrEUtkr1hG5CIOzn1Oyn2+Akcscwx6jXd1AI++gQ5wcKDv6gZjQfkLaQWkKwdKF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3499
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi80LzIwIDE0OjU0LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IFdlIG5lZWQgUFIg
dG8gb2ZmaWNpYWwgcmRtYS1jb3JlIHJlcG8gd2l0aCBweXZlcmJzIHRlc3QgdG8gY29uc2lkZXIg
dGhpcw0KPiBjb2RlIGZvciBtZXJnZS4NCkhpIExlb24sDQoNClRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9uLg0KSSB3aWxsIHdyaXRlIHRoZSBjb3JyZXNwb25kaW5nIHB5dmVyYnMgdGVzdCByZWNl
bnRseS4gXl9eDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiANCj4gVGhhbmtz
