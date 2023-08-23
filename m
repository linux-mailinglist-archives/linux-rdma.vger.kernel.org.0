Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BC785170
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjHWH0G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjHWH0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 03:26:05 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41218133;
        Wed, 23 Aug 2023 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1692775562; x=1724311562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZUWG7T6TIPhyr9Qbw9B29jWqxJiuopYxZgytnTWk2sQ=;
  b=f80YpUeMRoaeADihyDusQw74ReZVtiGPlXCVqv8oqAzDAKkPIQiR9oVD
   pin/j5wGSjI8OOQUSFSjZZRUtRCqCo0KRAbXga3mReTSvszW6wwmJMbiW
   mpt43T6nFqQ7evCXrAl4TBQmBUWCsxgzc30aBxtfuYShp+WJhELElAki8
   4c8EYg5dnV2cSBByXUW2lNimtYSfksy0lgqFgSJJpW7VhonarpdbwQW+R
   7BSz6irLP8iBO2FLsTmP01yYYTIh0HmOH2i5/UMBpxFBk2Uq8B5KZFdpX
   UF+fQ+HBrUoAURxhdXzN980wItSbkkFu7XYDWieXg8raXLN+KC3biQZwn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="93055617"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="93055617"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:25:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/jW9AatWgw1I6dOVCOw5qTrZL4uOBk10Nzy3i7W6DxgVfnQfQCNl52In9bPqFv9hZDHgs/2lvD//O1wU+7RLNb5grgofoVD7kAewdwBmp7JCO8baqAulCqUFf5+wxT+MT7HugkGYIAiKooie2KQT3W1IXQVs5c3u4xpEiPfvm47enPoeCNY7nxQhRXDxD1B6futwaHVhoMeuSYB26J0S/W6o3MWjMaAuhqpEJNCIJ254mDorV7O4ApeSUF17BwzNhfGAQfD9t0M9Ag9X5aN0BVSv57aRnNJXwkM2+18w+OT/TNuUOVgtTc2Z5/S/hOt8n8Y0iFfJJ4CLHc6YQTpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUWG7T6TIPhyr9Qbw9B29jWqxJiuopYxZgytnTWk2sQ=;
 b=BXslT8dnvy8nAcmFi6k4EIJdhqZIRGleETLcIGSZhliXQnoQD2PV8LtHpzw1E+3pwiCJEYN0XVbN/FOpOvEtjVLbayDSVrJor1Tk6ONQHCE6HKgSLS6fEXwXWlfl6gzIUObR9X9uTzaIJFyW5R2bZzca2BA6TfUZEjKsrcQdlpXtd3WQFdYLrYwokdlHdV9Zt/jTloPVEQCDxpiyGyaZ28KWPSSnEEudCmmrTboVtUmHP0INWlX8Fkbu/YyvwD5NEzauGRx6f7azM0/Dabomi/EJCj8MBKHsINd9LAvBbLQZ55O2Nz+nQe/yG3Aojcfw78FWD2gwr2cvg5LmWtr6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB9375.jpnprd01.prod.outlook.com (2603:1096:400:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 07:25:56 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::3778:11b7:b621:1650%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:25:56 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Topic: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
Thread-Index: AQHZ1Yi6o4zSFSaxzUue6oXlknvmN6/3cgXQgAAGdYCAAABMcA==
Date:   Wed, 23 Aug 2023 07:25:56 +0000
Message-ID: <OS7PR01MB11804D2CD51378BBA8D4716BFE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <OS7PR01MB11804F618EF235291066AE96EE51CA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <04b5879b-fabf-bf28-5a20-b65b555b72ba@fujitsu.com>
In-Reply-To: <04b5879b-fabf-bf28-5a20-b65b555b72ba@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NTA5MDkzZDctODRiNS00ZWY0LTliZjgtMmM4YTE2OTVi?=
 =?utf-8?B?NzcwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMy0wOC0yM1QwNzoxNzo0OVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB9375:EE_
x-ms-office365-filtering-correlation-id: c1845c19-0ea6-4752-3c81-08dba3aa30d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aK40PU8LN5x/m+GmNQZzMB2zoI73uzhzzW56ezjIAu6L8406Zi6JQn2UAVKEEMDUxwRujKz7OG/uLxNqbSozmZO6JO6rjxpQC1JR5AP++67USiL3NB3wU3gOXn6hRmPal9PkbjLOm1xQ/fdllzCs5SCJ0h2cZHD49evqpmABG2UidAdr+aUMkSn8gKecdVSQz6xNvvs+lBSyV1ytbB1n5895W94UMA6NsbUxH0N55Q0mZbMYcmYtl2wD4p/hlxKWE5VVOWvTHvDeO3QrUzJU6sr+LIKsa3Wz8jRuMChIWnb2WtSufOrqnaleL6F6nI+RXqwD4yBDUlm4E8yWVqpjPih/eIyCivK6BtBK9tFya/s/DxNpkt8K17ULJKlEcoR2gE42fNt7HzHdY9zFjA/6MiUIva8A0WUCd4JubQnfDYG+VfwwjmWeSVds4p1gWU7GcpPFVlnahKrgWc9yUwSeW7MKFsLzG6oALK1Cys9Xyy7DH4TA7OUKgvLYhHfDjvF0nK7bU8mDsofGfFgsV92xUkhj7t4o8HFoEouWqBLtvaIEItuV74rxUItZc97e1E7M4aJ/+Tp7ocHMs7aTtOZEcMYXYQCteP9Q5PGK6eEA7sLO+Rc7BiRzsl4ez499SGre21BEFLnTO/Jj4Yn7VCMc0VxZqTu0aEmIyjf2Imguovk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199024)(1800799009)(1590799021)(186009)(86362001)(41300700001)(110136005)(5660300002)(76116006)(64756008)(54906003)(15650500001)(66556008)(33656002)(66476007)(2906002)(316002)(66946007)(66446008)(8676002)(52536014)(478600001)(4326008)(8936002)(82960400001)(45080400002)(71200400001)(53546011)(38070700005)(9686003)(38100700002)(122000001)(6506007)(1580799018)(7696005)(26005)(85182001)(83380400001)(55016003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNmU0NCMmlha1RNZlBwS3FZNTVGaTJFUW9Eb2JXU1B0YzRVRFh3OXQweHNs?=
 =?utf-8?B?SjJkdlYzZTcvemw3VTZJOHZ2T2Vjb3NlTTc0UUNvN1dKVVJMSHFraHhsZTFn?=
 =?utf-8?B?N0V4ZHlXdlRnRnAxQ0Z0OG1vaWp6Z3lSVUdsb2VjZ25NeHowQWR2N1hKckNL?=
 =?utf-8?B?eTA2bTc5cmhIaXd6OXArbU5HdFlYQ2MrTlhBRDNOblJ3MmZVb2dDazFuZmFu?=
 =?utf-8?B?dmVJVzQydHF5Vk5XRTRNNFdJS0FUMVNTaGhjRWR6UGJkSzJKN2ZvbGlHM2dZ?=
 =?utf-8?B?OW4xaUEyU1FQK3BrS1hPazNURmw0bGk5Qi9tT0c3Nmp2L2xYT2g5WG5abmhm?=
 =?utf-8?B?VTMrNVFwZFZsd0NGTml6YURWdEZqRFJGMmtLYzNKNm1SUTV1MjdjejdTZnlD?=
 =?utf-8?B?UzU5QlB5M0N1OXZTK3hkdDI4MHpDa2FHQ3VhSkJYZU5IKzhWcm9SQ1dzbGlS?=
 =?utf-8?B?cFAxd2RRd0prSEZ2Nk9EQzZJSjRCM0hsczRxYzlHT1d4cGtvTW5XaFB6VVBv?=
 =?utf-8?B?cGRIL0V6NktuR0FYelM2L2Zoc3g2elIyMmFRbkJaaDhjQWxYemo3dlc0Ykx6?=
 =?utf-8?B?aUxlYVJWRnhVZ1hyN21Kc0NlYUZnQlpZOWpGd0tHSVZQd1dPa3lFaHJFcWVu?=
 =?utf-8?B?dEdIR3cvTTNyUWRJK2llajJIV3UrRW13bGVtWmtlbmVxNUthaTRYV2hDenRM?=
 =?utf-8?B?S3VJWTEzZkRUOHFGazJuRVkzVzZGL1YyQXRLOFNEdHFlRkhxVzRJZUxwVUhi?=
 =?utf-8?B?c0V3emtPTWw3YVJrcWtzVVJaOHJ0SERPNWtMV1JhVFkrbm9IMExURW1BNHUr?=
 =?utf-8?B?TjdyN2E5ZTRSUU1SVTluZzBMUi9NR1Rzby94SEMwaVArZzR0Z3pGRTY2NGp4?=
 =?utf-8?B?U015WXpna2Q1ZHk4QW9tZG9oV3J3UkFqNHF4cXg4Yy9yL28zalZJWHE3RDVj?=
 =?utf-8?B?YVh4UGl5UFVzWDRjR1hLUVJhMjZyRzF0L0RBOStoeTcyOXJ5OFc4d1RZd3NC?=
 =?utf-8?B?enIrQUVBODBXTWJBWmd0TU5PMEgyZURBcHdHSW5DcXNsVUoxZk0rUk5pdkVM?=
 =?utf-8?B?VFJITUVYNXVQbWp0ZlVSOVljTGRxUHJIQittMlFZVUhJUWZ6M3RIRHlMZW5n?=
 =?utf-8?B?YXVJakcvaGYyOGJGa0ZzOXFITmEyRUhjbXpBYzFQMDZpMVJ2bi9oQ29kdGNk?=
 =?utf-8?B?NkZYTEF0SzBwOExGZDRjSFd4VE16RVZxUXJ1eDVEOVBhK243UHJGL2E5REEy?=
 =?utf-8?B?bXlpS0dDbTJ1Y0hJNksxS2RvY1BvRGxDYkwzMkRCSGU0bXBtWkV2dUM1QWVv?=
 =?utf-8?B?VVdLb3dwY2ptd3FGdUJiWkYrSXA2RXlBRG1rVkszN1N3WVFmSmNJL1g4QUpE?=
 =?utf-8?B?TkZjMjY0Vkt1NWtWNXVxZDhiWmhKeThwYnFWbVlXcCsrWTFuMWFTWVRsNll0?=
 =?utf-8?B?NzBLUWc3MVAyRENBWTY3NzVNaHpycDhFYzNmNVJhT25pY3RiZlRNbGdEQlky?=
 =?utf-8?B?QUZWbllFWDh4WXJpbnAreXN3QU9UM2REOE1mMTNDMWs0anp4TS9UQmR3ckVH?=
 =?utf-8?B?cEFEdy9zS2NIZlZxNWFmVkxKWGlLbERrb211UXNZNDVXZ24rQ1dBWDllQ1hn?=
 =?utf-8?B?M2pSNGFLYW9IZEduOUZwTHh2RUMwUWpxcnY5VUNtVjBpZUZ3RWxDZWZjNEQ3?=
 =?utf-8?B?TW5Vemx5bzVQUnEvZEJ5VDFpelpXZ25vZ3pMZi9TSC92c0UxMFVZN1p2VmM4?=
 =?utf-8?B?R09VYktwVFFqTUNMR1QzOFBhMHpLVUtBcTU2UEFtWnJIYUtzUjYzY1Y2NjRD?=
 =?utf-8?B?SjZsSFpNVy9id3JkNUg5MzZaMU0zRFREamJET0hkak5NRVhhWFRVQlpyWE82?=
 =?utf-8?B?WWxta016OTZaOSs3K1ZCM2FDUk01S21GN1BXeU5XdG1iREZPRnZ6VVRPTzAw?=
 =?utf-8?B?Ym1ZTzBoMVlpUnZ0UTkwckVmOFFKMzBkeWhManZYM21KODFRbjh2TzNMQmp1?=
 =?utf-8?B?Wkswb3hncGdNbVh0U3did0wxMXRvbzJUZmRYWUN2UUhwR3B5QVVSdXB5aVMx?=
 =?utf-8?B?ZE5TdVllU2w0ejRQbTlFWDF6MU40VE5SUHJSTGRYWWUrRjNpYUtPajB3NU9H?=
 =?utf-8?B?N0RYRVZLMW51VWNQMmhUcXB3a3VlWENqRHkzMHpRemRqTDYyNDh5QlVYOW1F?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bhL6Mwo9LyKjkV7O6EeR5GA6oENAPA8GAVfIwk0xhYm6aH3yhXSrzgIA1EVlPSLMCN0DVxXUV2LfRpP+nhoysTgTampmU5SdEKxVNEY9nYrsGue7PY3YNHv4mVxfoqqXKI0ur3mRnD8FP8hyFUDUV0XvThbq76DG6FjdtXsbdaXM/N1KfdIbRaxJBUT6HoEEc75l03hFUZM1rP7Cq2cHOuorsPjVg5ARvreWzHMrWP7Tf0OqKixvCAR4Ue9S+nJeQkbdcsmZ+4oxpdtwM7typeSKxGmrE8DAgaVENBfaYa5QXPgx/P2js2AG6DlaRgcH9veImgvncHfivNc5I4SPGrpd2SRA3J76jzbwJCbuU1o3PAFS+uVK5NyKx3w3xJ7mp4OhbakoujEX3/8Ie36sHFPYLdFF2Nnf+99N5dc2Y/xUdk0scPJVP1UFOurhcLsDD/M394fcdhwqwruLDq2t6F3eUM5UKNOTPuESP1O1Rrv1Dc8/uZEGym2KG5nLsZy6sapPceHqbpBPMhwZwLFbb7ifcfHEzFsDu8kb8Y0tdPmIxv+iV8PdcmccMpeFaMO3dr5sKgYl6EIVxG6m6ju5G4syNbbPLAddK4fGKYxC0CwT4TPjimWt59t5BbXSxansuYiNCGIjIyFqL+qtJ8W5rNmiZLxCXduIMLyTmwTslgP6uV7VQGxyQG6o1+qn45cwWkr3gAoN6FPulHNDFpnAR/Ui8UooO4VnLAdcAFTbC6aJec8jcHATO5IfzTv4lSJxWS99AXQnAkEAHJZaQ7bi3aFeoXLTHfDQjb/kB9b+sm3do9YQ9K82v/eYfNWKaiJvGinsTv96UglVZ2LFRkOrWfbNRt9hnD3iFxI8yIxKhQg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1845c19-0ea6-4752-3c81-08dba3aa30d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 07:25:56.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHmmY0py3j1cXDqUX4eMYJaHTLVpJKEclyd0x8S59CHAbgzvpKviklsMVPmZYqVgvvbGTNgyhori5nOa7dcM5HUJ5bSYg2xKQsjsSC9RmXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9375
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMgNDoxNyBQTSBMaSwgWmhpamlhbiB3cm90ZToNCj4gDQo+IE9u
IDIzLzA4LzIwMjMgMTU6MDcsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+55SwIOWkp+i8lCB3cm90ZToN
Cj4gPiBPbiBXZWQsIEF1ZyAyMywgMjAyMyAzOjEyIFBNIExpIFpoaWppYW4gd3JvdGU6DQo+ID4+
DQo+ID4+IFByZXZpb3VzbHkgcnhlX3tkYmcsaW5mbyxlcnJ9KCkgbWFjcm9zIGFyZSBhcHBlbmVk
IGJ1aWx0LWluIG5ld2xpbmUsDQo+ID4+IHN1dCBzb21lIHVzZXJzIHdpbGwgYWRkIHJlZHVuZGVu
dCBuZXdsaW5lIHNvbWUgdGltZXMuIFNvIHJlbW92ZSB0aGUNCj4gPj4gYnVpbHQtaW50IG5ld2xp
bmUgZm9yIHRoaXMgbWFjcm9zLg0KPiA+DQo+ID4gSXQgc2VlbXMgdGhlIHNlbnRlbmNlcyBhYm92
ZSBjb250YWluIDQgdHlwb3MuDQo+ID4gUGVyaGFwcywgeW91IGNhbiB1c2UgYSBzcGVsbCBjaGVj
a2VyLiAoTVMgT3V0bG9vayB3aWxsIGRvLikNCj4gPg0KPiANCj4gaGFoYWhh77yMIE15IFRodW5k
ZXJiaXJkIHNwZWxsIGNoZWNrZXIgb25seSBmb3VuZCBvdXQgImFwcGVuZWQiICJzdXQiIGFuZCBy
ZWR1bmRlbnQNCj4gd2hlcmUgaXMgdGhlIDR0aCBvbmUgOikNCg0KJ2J1aWx0LWludCcgYXQgdGhl
IDNyZCBsaW5lLg0KDQo+IA0KPiANCj4gDQo+ID4+DQo+ID4+IEluIHRlcm1zIG9mIHJ4ZV97ZGJn
LGluZm8sZXJyfV94eHgoKSBtYWNyb3MsIGJlY2F1c2UgdGhleSBkb24ndCBoYXZlDQo+ID4+IGJ1
aWx0LWluIG5ld2xpbmUsIGFwcGVuZCBuZXdsaW5lIHdoZW4gdXNpbmcgdGhlbS4NCj4gPj4NCj4g
Pj4gQ0M6IERhaXN1a2UgTWF0c3VkYSA8bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+ID4+
IC0tLQ0KPiA+DQo+ID4gR3JlYXQhDQo+ID4gSSBhbSBhZnJhaWQgdGhlcmUgYXJlIHN0aWxsIDQg
bWFzc2FnZXMgdG8gZml4Lg0KPiA+IENhbiB5b3UgY2hlY2sgcnhlX2luaXRfc3EoKSBhbmQgcnhl
X2luaXRfcnEoKSBpbiByeGVfcXAuYz8NCj4gDQo+IHJ4ZV9pbml0X3NxKCkgYW5kIHJ4ZV9pbml0
X3JxKCkgaGFzIGdvbmUgaW4gbXkgdjYuNS1yYzcgPyBEaWRuJ3QgeW91DQoNCkkgc2VlLiBNeSBj
aGVjayB3YXMgYmFzZWQgb24gdjYuNS1yYzEgKGpnZy1mb3ItbmV4dCkuDQpJIGNvbmZpcm1lZCB0
aGV5IGFyZSBnb25lIGluIGpnZy1mb3ItcmMuIExvb2tzIGdvb2QuDQoNCkRhaXN1a2UNCg0KPiAN
Cj4gDQo+IA0KPiANCj4gPg0KPiA+IEZlZWwgZnJlZSB0byBhZGQgbXkgcmV2aWV3ZWQtYnkgdGFn
IGluIG5leHQgcmV2aXNpb246DQo+ID4gUmV2aWV3ZWQtYnk6IERhaXN1a2UgTWF0c3VkYSA8bWF0
c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiANCj4gdGhhbmtzDQo+IA0KPiA+DQo+ID4gRGFp
c3VrZQ0KPiA+DQo+ID4+ICAgSSBoYXZlIHVzZSBiZWxvdyBzY3JpcHQgdG8gdmVyaWZ5IGlmIGFs
bCBvZiB0aGVtIGFyZSBjbGVhbnVwOg0KPiA+PiAgIGdpdCBncmVwIC1uIC1FICJyeGVfaW5mby4q
XCJ8cnhlX2Vyci4qXCJ8cnhlX2RiZy4qXCIiIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvIHwg
Z3JlcCAtdiAnXFxuJw0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZS5jICAgICAgIHwgICA2ICstDQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGUuaCAgICAgICB8ICAgNiArLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X2NvbXAuYyAgfCAgIDQgKy0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9j
cS5jICAgIHwgICA0ICstDQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIu
YyAgICB8ICAxNiArLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX213LmMg
ICAgfCAgIDIgKy0NCj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMg
IHwgIDEyICstDQo+ID4+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jICB8
ICAgNCArLQ0KPiA+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMgfCAy
MTYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPj4gICA5IGZpbGVzIGNoYW5nZWQsIDEz
NSBpbnNlcnRpb25zKCspLCAxMzUgZGVsZXRpb25zKC0pDQo=
