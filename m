Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC07851CB
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 09:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjHWHjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjHWHjq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 03:39:46 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 00:39:10 PDT
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAADE79
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692776351; x=1724312351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uh2fAps23VpE+jO8pHZNe38zuRT66w2Ye77LHQ7JY90=;
  b=iD6mMz7c2BM5nGJeNr3WhQ+bMIBg5kDqTjct7I94g/e9qhHngBqnc/Sq
   ybZ+AYcWIoOrShEefTp1pL2pBQWIaLbCUhFucgQn3ZZaLem/45V+igQXL
   veJo8dQ2Cj4JYaoJM5BRy0FDwXImjzqI0+WaMbJQxOFbE0nxr3alfw3ak
   Y2ICWdZf8qsVGM7n2s3G3ElyEkmTNh+iNHX3nxrfQFiu7lE/aR3EjLTet
   WPvpzlN3bogEhQxFAl/jZucK9PJ1fXfyBrnbIse7uDwB6Rolx1afGxIAy
   D7D62YvK4p9XtNG4mjvq2M3HBDaV4gHvUQqmi8PPod+I2zFvH95etTfc6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="93083238"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="93083238"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:37:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=decLsqT1UCCQ3S2304ZiB+saR+2b/GqWgEubGgjHRho5+91jZzsr7+kU64lRF+BnjEkjO3aPVDxZgkRNJLxU2dO3A657iCQMsCDD2rrMzBf5F20q/xVe+F4RCH0IuUffq0ZTT5XC1UXHbwVX4HqPPcbjx3Vyk/Po2gZaN9OvWIwQZ7ZYsBSXfhFuNih7Gjos2ckmYLDsyM5JLdS2QiL37PZq9xNUAj+OlzSCcqEgS6DYArLmTEO9hupoJNwaT1Iz9SvEwj+frafba2gP+huZMcIKLNL+cGb78HZ0xDcSuZqs6+u1Dt+LsttTIXJBtYcX81yN2yq000Em9w7wlDRkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh2fAps23VpE+jO8pHZNe38zuRT66w2Ye77LHQ7JY90=;
 b=mnr/lay8mgNX5HO+cNW8wQ6EvNhOFAJ2UI1AGT2or1VB2W8tkXMzQFYh+UgetBjhiN0zuNOkXWXJ2mA9pKy/2Dum35MG7XY8yTGDCbEsbXbg1f/WtwtuyvH6qR0ueV3oFsyeMoYExANb6ECr1SC9HTgWsm1d2IldweojRf2nzBAVc9QRGsLRrlfivq3CjTkycRgphOsywSYeQgPiEWMIW6QJqrwUakT2gbWq+esN8ZP24h11kEZKZPUtNtuebKIJ/BfQBdo/JmjjFlvWSrhVUpIHpmlWSOu2nFpjnnBmQ9YR8sRPzjKpree+6s+csRI+DxViglMMLLUeBUkiffPZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB8601.jpnprd01.prod.outlook.com (2603:1096:604:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 07:36:58 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::6996:50d0:fd3d:15f1%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:36:57 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Topic: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Index: AQHZ1Yi6vF1u/D15FECJQTHJEnRCjq/3dd8AgAACmQCAAAKTAIAAAwYA
Date:   Wed, 23 Aug 2023 07:36:57 +0000
Message-ID: <c52b8305-f2a5-ddff-92d6-99be7f345ead@fujitsu.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <OS7PR01MB11804F618EF235291066AE96EE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <04b5879b-fabf-bf28-5a20-b65b555b72ba@fujitsu.com>
 <OS7PR01MB11804D2CD51378BBA8D4716BFE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB11804D2CD51378BBA8D4716BFE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB8601:EE_
x-ms-office365-filtering-correlation-id: 48d8e532-e0e9-416e-6fc6-08dba3abbb36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3Zqd3F2QP/Z5eXemRvvU9FMNU1/dvo80vLh1+CLBQoZBijVhdaFGwNCEkC+IzTLofg0YhLBrhDZIdEzZEPxejuXSROdq0/++Cm31hjH/CRYhGrrxMYb0PBq9niLJ+LN6kOJORy7E2kU1QdU0PbCaHv+6lIdtO0wsJs13oC4YWpRld3h+gMcN9bJl76sW9qYsbI0O7x5tPOS2bBsVmF9W//Nb3HZNr3FbzA5LECYUb2Cb3kBDmje0pDXMT5UYay6OD0+16Woid6Y8MY4WIUzuLwIybqKFpE0I8md0F8QeBjqKf/FLHODDCBw/7yeM/fDFALU6Ku9JpaQnMwz+iGybrCRY5zlLMV6Bol5wHeEYhcs08FanbHaJZ9oEvY7ZKnH1BcSW1IAoEFPDftxozxVx6B0b1LZtpb+lh+tS/aQ0FGbet27I2vu62kPpuda+M7SCmHTBs8XpVpQLjX4N+95IyNDm7uhZeIyWP0q4kKkGQD7K8dg2NTFpiIbgh67K1G+s+ywVAPW/cnShhabM2xeOa06CPH8dZogR5HPQeKyry5TeS5TH7RViXIBheD5KXNldQ9Q+7gDVb2Tn1UBSy2dJ311eetseeR8/oXhw3cCUXf5P69neuY8brNXMkfUxrYaTE4tB72Kx9tOGv/xN5FnNRhbQEVA/nfDFqE/x+69y6MIsSomcetcDkar7QhUVZyqoumrNg6CmJXeP1pg7cw7nt8tj7NonrABI25doDM4qo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(1590799021)(451199024)(186009)(1800799009)(15650500001)(83380400001)(1580799018)(2906002)(71200400001)(64756008)(316002)(66476007)(66556008)(6486002)(66446008)(6506007)(54906003)(53546011)(110136005)(91956017)(76116006)(478600001)(86362001)(85182001)(36756003)(31686004)(66946007)(45080400002)(5660300002)(2616005)(26005)(38100700002)(82960400001)(41300700001)(6512007)(31696002)(8676002)(122000001)(38070700005)(8936002)(4326008)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZxcXNaTUxxN3BMd20wVDZnLzNqYmFTd2ZuRTFPQXpOKzJITFdlMWpQYlFS?=
 =?utf-8?B?ak1RWDZXRGwyNmlRRGk4R3J4b09LSDBiWmpXMGxVVFh6ZTkvN2tFOUlDWGMv?=
 =?utf-8?B?L3dGamN3REsyeDRVMmR4a0tWMnFtWGxKdXJYSmkxdjNVUDdMQzRsbzRLWlVa?=
 =?utf-8?B?dE5DWTY5Qldpd2pzUEhFWG9nYXJuNkUwTzFQdVU1Q3c1SlFwT09kVkV4R3Fw?=
 =?utf-8?B?OFd0MDIyZU1FWHlnQTA2WTZteWZlcmZGTlRRZVhDMlQvVHVsc2w1ejN6dC9E?=
 =?utf-8?B?ZkdIbGptb0NEZjh5SFkvMjZjR3gyQnNjZWhiZTVpUFpycEVJc2lJTmlrdFNN?=
 =?utf-8?B?NnJmWGRYeERZeFg4SDN5YkxaYWdmTEJvR05XcjVnVXJrUDZKS090cVZvK0Vy?=
 =?utf-8?B?dVdpMGZYZFdFSUozcjJIMHlPdUkyNjBjc214K2E1alg4RUNxYllwOWF2VkZM?=
 =?utf-8?B?Zjl3S2RjQU80OVJmWGVyV09FSExhNFpKc0puVUlRS0F5cDhFKzFjL2dJTVI5?=
 =?utf-8?B?ZklWaDZiWlJHYm9kZGZMcWIwT3R6QVU3d1BnaXlUSGQxS3AzK0lneHBUekp4?=
 =?utf-8?B?M0VpUlZnR0RRMDVpRVlIZlZTSWpxb0dmeWFtQVZ1Tk9jdm9DM3hCSTFLV3po?=
 =?utf-8?B?amxZblZMR29oM3BMODlBQWlmRXVXVWRQYWcvNUVJdTEwQ1JJWUo4UEVzVHZv?=
 =?utf-8?B?cTRiK2JkSGx6WDhZMzZNM1B1am43bVhlbTJPa0psSzZpOVN3ZHBBdW5TL0ZT?=
 =?utf-8?B?bFRtWGZQeWZMSmlNRnZQMXkydXJ4S0FHV003Q2lraGJxalcwZHhhbDhzS0hy?=
 =?utf-8?B?cVhxS3VRM2swR1cxVktGVXFSRkMvaGloaGV0Vmt6SisySmtRWWhYVGt0L1hJ?=
 =?utf-8?B?UkJTb1FoMmhSSWg5VXFhaFdranRMblBTc2FSa1A5TVBwYUJDNzc3WnR2SjVE?=
 =?utf-8?B?STJTZ1BUK2htNkNHTHQ2QTVMK2dyZXNQTkxkN0l5K3lEWGx5VjRsb0tFazhE?=
 =?utf-8?B?eWdQYUxkeXpHTTdGTjZja3k1TW5jUmEwRnFIeHA5emRGVmt3T1E3RXhLalcx?=
 =?utf-8?B?RUljaUthSDBWcHlmcGowN3JNVmdqcElvVk56a2hJVzM2YkhqcGdEbnVxR0lI?=
 =?utf-8?B?T3VtSStCL1lkQWpoV25SWUxJYWlZR3hSbStPbjF0Yyt2MWhCYWdzMEN2eGpT?=
 =?utf-8?B?M1JHb2VsRDM3ajBuZzc3S2w5aHREcVM3MXFqT0JGa2N3VitvRWxaVWNtamZn?=
 =?utf-8?B?VHpYMUxXNHp2MHRNYWpIZzI3dEtqVzhqZlBORkxKQTVyd09TUjBIVGxjTlpK?=
 =?utf-8?B?NTlNQjgvbmFKems0MTJMcUZCOTNhRzQyL2U1TUI2eWsvZ3k3MGRubGVGemN0?=
 =?utf-8?B?NHRIamZjbjBxODh2cG1JQnIyQ2xnTjlHSjVFc1J4bDh4QmtDU0dFKzJidXBW?=
 =?utf-8?B?elgzTEF0QkoyRVpERG9RVlE5UE8xKzY1Tm9WS2dXQ2dIcm9zd1RJWXV0RTV0?=
 =?utf-8?B?MFJvUTRYZjBRZlJWYm1XMGo4VDVRUVVrZG1pMmptYk4xQU54VHBlQUVZcWhy?=
 =?utf-8?B?RllUaS91cDhPbHlNakZPTTJmekdERk8waFNCZTNaYWpDZ2FoMTkyc1dnc1Np?=
 =?utf-8?B?NUJCRTlzeHBTVGFnSzBVVWRFM2pRdUVrd0NWLzArdHZnY0FsRVJKOGc3VUJw?=
 =?utf-8?B?UmNtck55QndnOEpJNTNUTmhLc3d4OUdBMjBIU3g4UGRBbmRzenlvOXg2YUxi?=
 =?utf-8?B?Q204Q3F6YXZ3bUdZQ0N6cUE0c1A0NER3NjlCRkVnYlNYT09aUWlVWm50MDRi?=
 =?utf-8?B?SGt4ZTdkb3psNjhkalJzTS9tNzBsejdnVFRncGk2V2k1Mk9uSzhjZHpmTkVW?=
 =?utf-8?B?RzZqd1U2VDVrUFY5dGNmRGFVZUJoZjE3aU5Ed2hCSFJFQUU5Y0RLQVYwZmN0?=
 =?utf-8?B?MDMyNmh6Si9Va1o4bjJvWWZydVhEWlhmZkdMaGRsZ3JBcE1LTU1xeUdqcmt1?=
 =?utf-8?B?UENRWUxBaU4zK2RwRkFRVzFOd3ZxRDJNZDVUdVFvTE1Pa1NGdUg5U2g0Z3Vl?=
 =?utf-8?B?Y0VZU0NEOVVzc2FxMjhyL3lGdml4Q2RJcHFLamU2NytCa25ZZjRqMkEwOTNW?=
 =?utf-8?B?c1Z1SzJvZ1FrWXRYR1cvb2lrckdEUXhXOWVOTjJQa3BMMHNDTlc2VFJQT2k5?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <497BB98C36ED9D44A9072C4EF4AB174E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x3FJ97cjvnq/cfYeOr8EqvzVjdGNNr+hhkONjhbfEOKPdwElKaUgHnejJtBj05Z1gXGzi24xthual5ATzj3ua6zuxdDPObLFMp8xv0yp6Zhtx1nsmTqiJhxfPMOxssETjYJZWtVNRbx6zEVQmE9RQXx94tbuIk2RbgdvCBLUXaKF9cxj6Ry7t3XOaAp5e5ZCjoDmOLWA6Mk63c3UsWgJ2rc3q2iBWwsypyYNmYQSNo/vp24L4DwEMOB3umN+HgVnzRJuYMv1fp4pi9uY8l/xDXAsYM4YzH6VW5WA4mJUQhKy+dB/NzlyaxZ/xo+hI2EhdM4/jC5oxkQjvt1ko+F+fwfmxjnAYU+i0hGGISYNpH6PXlL0emvBmvmVatgzz+aCyyWJ0ZxEuaL4cVLLxTPnhA8BsPFONOB8k1CUWWR+cVgeAs6H9WaXs4mXLwP2ViQvl7fM3WOMENXl0LS6Q7wCeIj8y4yZqH4NJMQG62J1Q3F8ggfE7LZV4Fvbukn/EETvUfEAz0EYXLow87Q23/Qxfa/Mg2zS62IjIG1CxnYEE2KUfQ78Z3PvMYpUZe45wg9zp49LcQrwwljFkWyvGhVnjQClmW3UdnRr61SDoRvpHsPSm4GX88TU8Mcgns7Gi8wi9uYcJeA5OgwkV7ooCdguX6EmJ0F+2xFBjSUI94q0qjPzIV0AJKoc4eHB1soEmYav68UZiAMugW/anT0z9oPbKaoi0CnVeMVIY9co4Kfu9DmaTG1Qkt0zkepykEsjOdHCBtEMgMxs1yv6XFhEHdPbuRLevCZ2fWOj4GMTEOlsxJ1LsfQaOLy+m6aT27pM3j4dH9oRfd8up19ah5IpSX/dwj6yRWnlHuuaR+LrtGYvlLs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d8e532-e0e9-416e-6fc6-08dba3abbb36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:36:57.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4AqA4aZQ5M9802MhhEeQMR5j59zyXqS1xak84eYFIqnqllGSV6ucFEtAGQiaCIFXQ2DCleHcCpnvki2XHigAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8601
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjMgMTU6MjUsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+55SwIOWkp+i8lCB3
cm90ZToNCj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgNDoxNyBQTSBMaSwgWmhpamlhbiB3cm90ZToN
Cj4+DQo+PiBPbiAyMy8wOC8yMDIzIDE1OjA3LCBNYXRzdWRhLCBEYWlzdWtlL+advueUsCDlpKfo
vJQgd3JvdGU6DQo+Pj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgMzoxMiBQTSBMaSBaaGlqaWFuIHdy
b3RlOg0KPj4+Pg0KPj4+PiBQcmV2aW91c2x5IHJ4ZV97ZGJnLGluZm8sZXJyfSgpIG1hY3JvcyBh
cmUgYXBwZW5lZCBidWlsdC1pbiBuZXdsaW5lLA0KPj4+PiBzdXQgc29tZSB1c2VycyB3aWxsIGFk
ZCByZWR1bmRlbnQgbmV3bGluZSBzb21lIHRpbWVzLiBTbyByZW1vdmUgdGhlDQo+Pj4+IGJ1aWx0
LWludCBuZXdsaW5lIGZvciB0aGlzIG1hY3Jvcy4NCj4+Pg0KPj4+IEl0IHNlZW1zIHRoZSBzZW50
ZW5jZXMgYWJvdmUgY29udGFpbiA0IHR5cG9zLg0KPj4+IFBlcmhhcHMsIHlvdSBjYW4gdXNlIGEg
c3BlbGwgY2hlY2tlci4gKE1TIE91dGxvb2sgd2lsbCBkby4pDQo+Pj4NCj4+DQo+PiBoYWhhaGHv
vIwgTXkgVGh1bmRlcmJpcmQgc3BlbGwgY2hlY2tlciBvbmx5IGZvdW5kIG91dCAiYXBwZW5lZCIg
InN1dCIgYW5kIHJlZHVuZGVudA0KPj4gd2hlcmUgaXMgdGhlIDR0aCBvbmUgOikNCj4gDQo+ICdi
dWlsdC1pbnQnIGF0IHRoZSAzcmQgbGluZS4NCj4gDQo+Pg0KPj4NCj4+DQo+Pj4+DQo+Pj4+IElu
IHRlcm1zIG9mIHJ4ZV97ZGJnLGluZm8sZXJyfV94eHgoKSBtYWNyb3MsIGJlY2F1c2UgdGhleSBk
b24ndCBoYXZlDQo+Pj4+IGJ1aWx0LWluIG5ld2xpbmUsIGFwcGVuZCBuZXdsaW5lIHdoZW4gdXNp
bmcgdGhlbS4NCj4+Pj4NCj4+Pj4gQ0M6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtl
QGZ1aml0c3UuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5A
ZnVqaXRzdS5jb20+DQo+Pj4+IC0tLQ0KPj4+DQo+Pj4gR3JlYXQhDQo+Pj4gSSBhbSBhZnJhaWQg
dGhlcmUgYXJlIHN0aWxsIDQgbWFzc2FnZXMgdG8gZml4Lg0KPj4+IENhbiB5b3UgY2hlY2sgcnhl
X2luaXRfc3EoKSBhbmQgcnhlX2luaXRfcnEoKSBpbiByeGVfcXAuYz8NCj4+DQo+PiByeGVfaW5p
dF9zcSgpIGFuZCByeGVfaW5pdF9ycSgpIGhhcyBnb25lIGluIG15IHY2LjUtcmM3ID8gRGlkbid0
IHlvdQ0KPiANCj4gSSBzZWUuIE15IGNoZWNrIHdhcyBiYXNlZCBvbiB2Ni41LXJjMSAoamdnLWZv
ci1uZXh0KS4NCg0KWW91IGluc3BpcmUgbWUsIGkgc2hvdWxkIG1ha2UgdGhpcyBwYXRjaCBvbiBy
ZG1hL2Zvci1uZXh0Lg0KDQoNCg0KPiBJIGNvbmZpcm1lZCB0aGV5IGFyZSBnb25lIGluIGpnZy1m
b3ItcmMuIExvb2tzIGdvb2QuDQo+IA0KPiBEYWlzdWtlDQo+IA0KPj4NCj4+DQo+Pg0KPj4NCj4+
Pg0KPj4+IEZlZWwgZnJlZSB0byBhZGQgbXkgcmV2aWV3ZWQtYnkgdGFnIGluIG5leHQgcmV2aXNp
b246DQo+Pj4gUmV2aWV3ZWQtYnk6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1
aml0c3UuY29tPg0KPj4NCj4+IHRoYW5rcw0KPj4NCj4+Pg0KPj4+IERhaXN1a2UNCj4+Pg0KPj4+
PiAgICBJIGhhdmUgdXNlIGJlbG93IHNjcmlwdCB0byB2ZXJpZnkgaWYgYWxsIG9mIHRoZW0gYXJl
IGNsZWFudXA6DQo+Pj4+ICAgIGdpdCBncmVwIC1uIC1FICJyeGVfaW5mby4qXCJ8cnhlX2Vyci4q
XCJ8cnhlX2RiZy4qXCIiIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvIHwgZ3JlcCAtdiAnXFxu
Jw0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYyAgICAg
ICB8ICAgNiArLQ0KPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5oICAgICAg
IHwgICA2ICstDQo+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAuYyAg
fCAgIDQgKy0NCj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYyAgICB8
ICAgNCArLQ0KPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jICAgIHwg
IDE2ICstDQo+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX213LmMgICAgfCAg
IDIgKy0NCj4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jICB8ICAx
MiArLQ0KPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMgIHwgICA0
ICstDQo+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMgfCAyMTYg
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+Pj4gICAgOSBmaWxlcyBjaGFuZ2VkLCAxMzUg
aW5zZXJ0aW9ucygrKSwgMTM1IGRlbGV0aW9ucygtKQ==
