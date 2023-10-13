Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6E7C853D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjJMMCj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 08:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjJMMC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 08:02:28 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4C189
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1697198520; x=1728734520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ys++X4yo77X9FXf50qYK3Vzg4Mo1dAUDibST62r7bE=;
  b=dV5np13fQWhMvJInpfnZPzTIVqS+i5LXt9hY1HYhbZtLQeo66Kqqf1cB
   ZlSn2s4cp9NNuM9c3DxXnQBr1z4nSOFOal+qnjEs3pDccx3jj0gt0zG03
   dpXQ45wGopCpz3lAUXeX2vi5uqnfiDbycRgo2EiohGu7RWGfNL0SO4xSp
   CldHAMPl46y73qjtMb+KNcSE1YaBhNucdGhFT9z9DSh03crhewdHXqTP8
   0zI4B50qNv7uc6hO+/F+IPs2Kg7x4+Y3f2EnU0FZjtexXBV+c3iyDylbA
   qUnwk//mNnazpaEvC2Is3f3AHYWPfSgXSd25OVX26e7Y6clxc1KCoRFGj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99456863"
X-IronPort-AV: E=Sophos;i="6.03,222,1694703600"; 
   d="scan'208";a="99456863"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 21:01:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lotgZ4avzUYNeG7xyt8P7kW4ZrxrtchK+F5MZiXUnFwYLX2C/tpHVXFc/aG4tc2uD40FCdS/LX+BIoFBu+Y6GX3SQaA+++lhBKSi2hi9iD7gVWZrKLFWPvfoto1FCT5oBpvhUOVlJxczvjH29TXKQOsEOeHeMuDDhBapSAkuXn/gfM5jBWJrd1/w/+/N9/VRdvRoxQXnkWqlCDswbTtB7BWgK/pvLql3U7kUobwzycyqY1q2iPdq2MPN6MAM0iM5NlEK8315HHRfgxtWbmLS1eypC2XYx4VR+kdXs6M8x7n03yw9ZmLTGT3HiPy1Cj35KmyeMflCnXxG/8oGgJ4M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESpYqd0MU1gKzPOv/ByzRIYasZvPZi3OqMd3JUYt5ik=;
 b=AzQxpwTaPdlyiWAipL1iWpZh+DLXMVepRYxcaGT9GKORdZE4mXn4HQmd5XHJgtQVsusBD3wRykWttonoeGVvWS4r7d7GHF/dtL8RvyjJXFlW1xhKsmNKatu6FarKVNXD5y66S0f46XY6wao9iR1aJLCjz8PTocL3Qkpx3Fh7avjgElZSqMmCOfCEzGLRY1BJsZXCUkFz3aDXJkOvpCFu1DpXq2NhNjYwx4sqAwhxYsGLP7Ihu9Gqjb3eAfHAAyvRcB4QW3jCSQehdeq9E+nKjb4SW6okqTv3tOWXakTNAwHEYT0Zztvy6azzVQRbEQaHctipq4/2PgPWv//044Ihow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS7PR01MB11407.jpnprd01.prod.outlook.com (2603:1096:604:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 12:01:53 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 12:01:53 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <yanjun.zhu@intel.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with 64k
 page size
Thread-Topic: [PATCH 1/1] RDMA/rxe: Fix blktests srp lead kernel panic with
 64k page size
Thread-Index: AQHZ/XL92/TSgxYyx0mXQnQUi6BiibBHQm7g
Date:   Fri, 13 Oct 2023 12:01:52 +0000
Message-ID: <OS3PR01MB98651C7454C46841B8A78F11E5D2A@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20231013011803.70474-1-yanjun.zhu@intel.com>
In-Reply-To: <20231013011803.70474-1-yanjun.zhu@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9Yzg2NDY1YTMtZjFkNy00MDBhLTg2Y2YtMjA5?=
 =?iso-2022-jp?B?Y2FhMmUyZjJmO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMTAtMTNUMDY6Mjk6NDhaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS7PR01MB11407:EE_
x-ms-office365-filtering-correlation-id: 56c4b053-9084-4ab7-6ef7-08dbcbe4308c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w//p/rduCOVL02oWJ/pLmYEMFfnnZFU3Ln5YSNRjOALB8faqef76gXeX5VIaui3rm8tfTtQ0oTtQCR9iegdq7NljgqgHPE1MahZgO1y2QP80un+ymOPv71VGuj/I1DGJ7Yi7+sxBJjX7G3h+R+u+8d0vKIjUbe3oruMRhKkvfsPI8tTuIHsb73BQK40du56Q29XNPXh0kyhuR+lwHLIkgrPLD8KvneK6w0RIV3gvpt9kMfRunxNMbxRt+Nvp/0CcIMvTvcEZX/cfVL4f9rpmQCIw6+yQsU7rMz5LWdybWxtR/4om3pHaTOOaI0GDNPePsLXIHLL+useE/tblwpcy7g5dPwig1zMBwf2lkjU1NeBreSaJuswwy4FJiKEQSni9WdDplNPjmMWcyuhUWlsmKx3puS8tjtNIpl7+8pry5GLUvE3mHZ9MtwWInre6lC7uJFb0uwx6sSKiqAf9BbOPBOKqVPY/6dgYoiooik901mHuaeE0af4ivcA0JQsu55BKCH9ZhRBVdsvYEEwkFv3PMuae7IMUqsQqcSBKSY6HB34o5r9u5PS25Xd2+4ES/KZffqLUvFLWoksEsYsj81v90xEz5xxeebEXmcXTWoWn2H8qCRRxn/x943U9txVS2KmBwaVk4vC0vLDdhg0fUsC6eQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(1590799021)(451199024)(85182001)(55016003)(86362001)(33656002)(66899024)(1580799018)(66556008)(66946007)(54906003)(76116006)(316002)(66476007)(66446008)(64756008)(110136005)(82960400001)(38070700005)(38100700002)(122000001)(53546011)(83380400001)(41300700001)(9686003)(71200400001)(6506007)(7696005)(26005)(8936002)(478600001)(2906002)(8676002)(5660300002)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SHg4VUJuZ3pEWmx1TWwvQ2cxd2paay91N2hQSjNQYTZ2VGlHaCtvUlp3?=
 =?iso-2022-jp?B?S3VoanVjdkN0Nll5R01JQVg2Y2liWnozYUZCR3FMTVVvS2tXQVRBcG9s?=
 =?iso-2022-jp?B?cksxMHphMlNqTW9ZQ2p0NkMvRy8xU1RxOHI4S0NPZ0JBRTNWWndEY3Jt?=
 =?iso-2022-jp?B?NlJ1YzFSMUdDNjk1VVN6QlJMcUxpb2tFRWdGRHJGOVB4U2xiWG9xQkxT?=
 =?iso-2022-jp?B?cjArY1Exb29FOFo1T1lKTGswT2sram9nN01PNTR5Ykx4U2FsWXd6U2xw?=
 =?iso-2022-jp?B?MXdzbUNyOXBFdUVtejg5SmFtelVZV0dURE5TV0xETnhRNmZhdXFBbVIy?=
 =?iso-2022-jp?B?S1F0VllacVhWRHA2MGhLcXZMazFsdTF0MzBjaW54dFhUWlJtS2lyYTQw?=
 =?iso-2022-jp?B?aDdwQVFHRmpWTC82RFRzNHc0d0lrbEZTZXVJOWt6LzVIZUM0eTVQQm8w?=
 =?iso-2022-jp?B?WkNlL2l0L2ZRVjdKQWVWakR4clB3UmJtb3VrNFhzTU9vWXhGWnRsYU9S?=
 =?iso-2022-jp?B?eFBsM2NuaWlNNHVSNU80cnNDOHVsMG1tZVJ2dTMvMHFkS3RBdXFPTnFT?=
 =?iso-2022-jp?B?RmprTFVzMTRBdVVrZFVtbW9LSDdMODgvMkZoTVNYVGV1SWdaNUR4WVJQ?=
 =?iso-2022-jp?B?emh2MHFuQmE3Z1JheHhoVUZvdnB2YVNoTTE5QXJrQmVZT24zdFUreFFj?=
 =?iso-2022-jp?B?MEdKWnV5bnpOYno5OUk1Q0czdXBLQU5Cdm1aY2VaeTF1ZkRTcFVMWjls?=
 =?iso-2022-jp?B?aDZIM2tUcHZFYmtMbmpUVFYrSWsrWkxoL090dm9PQlY0M0tjUG42VVZi?=
 =?iso-2022-jp?B?K2xIUlFIUlBiZEczeDd5RWFVVjZLd1F6d2phSFY5MnpZZjZZRndmMjdk?=
 =?iso-2022-jp?B?RWxvUVZXUWZKdDY0eDdvSjhXcjNzdC9ndjBEb05UdEthK0h1dXNJbDVV?=
 =?iso-2022-jp?B?SFh0dGJqTVlzTnF2YU9leTJoeXdQR1I1SVA5dkpYYUJTV1FOdGc0ZjZL?=
 =?iso-2022-jp?B?Qy9TaC9qWURSNFV5bW1qVjZERHo4OXVYZHRuVFNvaytFYkU1djN0MEdV?=
 =?iso-2022-jp?B?cG9uNzBmb1dqSEdsMC9KME44UnNRSUFXRnRWK1dWUjJsMVBxeFBDdW1r?=
 =?iso-2022-jp?B?VXZLcFIxUDdNazZOaXV3blYzWEQ4cUduSWdpczJkdnEzVHlCRnJ2S3B5?=
 =?iso-2022-jp?B?STA3MFExK2FYWkdQN1VwNWhBR1JuOVNTUEU4ODV5K1l2SWxBdG5IbnF4?=
 =?iso-2022-jp?B?NWdWOTJqOTdyVDBKWk1yUlNtT2YrUU5kekJ6bE5XR3hyQ2FMa3liejQx?=
 =?iso-2022-jp?B?SjFnS2p6YjAvWTBQV0FkM1FNOFNYa3hYSU05THRtMWo1KzlFd1NoSkk2?=
 =?iso-2022-jp?B?VllwOVVla3pNUVVtZlg0WmdMN2FMay9oTHhHemlGZEs2OUVEM2xCazB4?=
 =?iso-2022-jp?B?OVFYVFlKMEJyV1NmMFpkZVBxM1I2blNzMmFqN3YyK01jS1RGTjJVdVpj?=
 =?iso-2022-jp?B?ZGdubStqWDltMVlXY2ZRYWRUbDFqRko4TlBoN2k1amdLUDYrUjdwellx?=
 =?iso-2022-jp?B?SnNkVXhDQjdxdFBid2wxOURTaVJwNVFzT3Y5OUJUUTFMeGR1SUNSQ3lN?=
 =?iso-2022-jp?B?bWJwVHBYZUNIbHBjTUpvakRWdWtROVBBaXlQKzg2ODNZYm1BakhFb3Rn?=
 =?iso-2022-jp?B?UmlZMVpaZ2pJWGhqeW1vVEgvQVlmdXVZRXMrN1pRa3pFbFdDam9oY1NI?=
 =?iso-2022-jp?B?YzlnU0JmUDhNTisxK05zTVViYVc1elBtSXF2Q1FVZU40eGNBZEFnRkdy?=
 =?iso-2022-jp?B?d0pCTEg2aUZEVHUvd0JCRmh6eU1HZ3RqeGlvRTV2YVd6Qmp0Z3NmK29j?=
 =?iso-2022-jp?B?RncxenNveDR3anIvdEFXN09MSHNnOUtsMEI1dm9QUUp5cG9LZkN4SjhX?=
 =?iso-2022-jp?B?cU12U0hEa1VHTEh0ZVRZY3YwL1RwUGxiVnA5YUw1TTBwaEVpVU80K2ZB?=
 =?iso-2022-jp?B?QkFNNDVIS2Y0OHBNTCtXS3lMbVV2UWNzWHBSSXVUNU9md0JsbG1wY1NI?=
 =?iso-2022-jp?B?a1crUVJCQll4cHlTUldaSHd5SlREdEljeVVuNE51cklqRWNTUU15MXNo?=
 =?iso-2022-jp?B?ekVKWUdmRE9vTVJaL1RETVdxeWVoYXdJZzcrMWFsV3pHVGp2NkdXaThG?=
 =?iso-2022-jp?B?MkpJUGtRU09xU2theUgwQWxLWjh5UlIxc2xmaXRxbUZpZnBrdzlPZzVE?=
 =?iso-2022-jp?B?OU9iN2NOVUU5d3ZMOWFlekNGMGdxTkFYT3NSbVd6TkZJTVF2WVVFc28v?=
 =?iso-2022-jp?B?REdtRnNsRmI2UG1TNVBPUS9WbStSNVF5Q1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?a09hSmlJZS9vRFhCK2p0by81M0RiTWxmbElVTlBZUER5cWZuZ0MrWDA5?=
 =?iso-2022-jp?B?ZnErdGxiQmUwZHhZOG85d2tNN0F5MlBMUEVKay9JVlhBWDVJNDRaL1Bo?=
 =?iso-2022-jp?B?dXVhK3JOK3dndFowekRYeEtnVyt0SWNCR2hkcDhzdCtwNVZocGJXNnJX?=
 =?iso-2022-jp?B?Skt0RkFXWkUvazBsOUE3dEwvSktLc3hVRjF4V05sRUcvL09CalpyY2Mw?=
 =?iso-2022-jp?B?MVVHd255WXExaE5icDU4amxaRjFCb3lBeTVFRFQ1S20zY2NSUUVLdWNq?=
 =?iso-2022-jp?B?K0F0UFZIazNMQXhnN3Y0dTBCRWRhUE9UMmpJYmowVHo2cFd6RHk5ZE5z?=
 =?iso-2022-jp?B?MStqZTlNL0dsV2M3RDNmcnFNdmlHdDdHRy9SQmY4bVhRWVFzSDZTaWlJ?=
 =?iso-2022-jp?B?TU9XS1cwRVk1MkNzenEySE9MK3lxUlB3TnU5WGc3YWdmd05MVFFDazVL?=
 =?iso-2022-jp?B?NXRrN2xmMmM3ZFpGWHpTeTJKR1BIUFJYd2dabmk2d3pVL3ZhaG1YT01z?=
 =?iso-2022-jp?B?ME9mNElnUGFuY0JjTisvVy9uYkx0NzJMYkZFdVZyWUNjUkMxZzcvUE9Q?=
 =?iso-2022-jp?B?Zy9XaGswaS9TV0NhdTlRSDFyclN4Qko3ckV5djN6WWtTWFRaQ1RPZGFq?=
 =?iso-2022-jp?B?STEwSUJxQVU4N0N0a3dEQ3Q2YWZOVmhqZ1N5VE1RbHhKeWhTeXN3NnBX?=
 =?iso-2022-jp?B?R09ZTnZTVWFkVkc1ZVBWdHc5ejRNaTdHMW1nNU9xbVp6cDVSbXZyUmMx?=
 =?iso-2022-jp?B?cHN6YlRtdisvdE1CWFEzVE1OVUgyQ1hodmJwbHBINkxCdkdFL3VYUm1p?=
 =?iso-2022-jp?B?MzRXWEtHUlExSkN3WDRiOFJJUDNKK0d0MmlmU1BwVHJTSEIrMjQ4dmVY?=
 =?iso-2022-jp?B?anJSaG9Yd0trckMvb1lXc3FyNXltNDE4ZXBKbHF3b29BWHJmMHJLOHFs?=
 =?iso-2022-jp?B?a2VzVFU5VGtHcFpHYm91c1R2M0g0dXFPVEdoRlY3N3BoOVVWbldCQ0xl?=
 =?iso-2022-jp?B?VEhFYWNFN2hkT1JMRlZ5VWkxbitKcitURUszaXF5b1ZTY3BoV1cvVDNQ?=
 =?iso-2022-jp?B?cWU1M2VCeG81dGtMVEdMWHlkcENsUk5PR3hiYisvenptMkkwYXA2SmN1?=
 =?iso-2022-jp?B?UW8vRFlIU3A4WEdpUHNnMnI2VEhaV2Erb1VvT0lSNTFJRkMxcDEwc0Zy?=
 =?iso-2022-jp?B?VmlVampxUWpYZUlBUkxkUUI5NnBjUGI2elJoazNNZ01yZEZkT2FwK0Rw?=
 =?iso-2022-jp?B?RXRmRXpvZ2dONXZERTBldmZMc1ZMNVUwa2tQSmt0ZEY3WlA2Z1p0MFdB?=
 =?iso-2022-jp?B?V2pPVWhwV0ZwSGx6VDNjUUVrNUxSZTNBL3VjaHFiYmpvamg1?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c4b053-9084-4ab7-6ef7-08dbcbe4308c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 12:01:53.0273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiNn80+cyEZoeyYkzTjWZOFbO3K/TRwZyETm9jdpoiC2ZltRUqbuqqTYRDJtTw6xC01TUKn3aBkNWT9BXND4sYh4NaoqshKlN/EFhHXVUbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11407
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 13, 2023 10:18 AM Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> The page_size of mr is set in infiniband core originally. In the commit
> 325a7eb85199 ("RDMA/rxe: Cleanup page variables in rxe_mr.c"), the
> page_size is also set. Sometime this will cause conflict.

I appreciate your prompt action, but I do not think this commit deals with
the root cause. I agree that the problem lies in rxe driver, but what is wr=
ong
with assigning actual page size to ibmr.page_size?

IMO, the problem comes from the device attribute of rxe driver, which is us=
ed
in ulp/srp layer to calculate the page_size.
=3D=3D=3D=3D=3D
static int srp_add_one(struct ib_device *device)
{
        struct srp_device *srp_dev;
        struct ib_device_attr *attr =3D &device->attrs;
<...>
        /*
         * Use the smallest page size supported by the HCA, down to a
         * minimum of 4096 bytes. We're unlikely to build large sglists
         * out of smaller entries.
         */
        mr_page_shift           =3D max(12, ffs(attr->page_size_cap) - 1);
        srp_dev->mr_page_size   =3D 1 << mr_page_shift;
=3D=3D=3D=3D=3D
On initialization of srp driver, mr_page_size is calculated here.
Note that the device attribute is used to calculate the value of page shift
when the device is trying to use a page size larger than 4096. Since Yi spe=
cified
CONFIG_ARM64_64K_PAGES, the system naturally met the condition.

=3D=3D=3D=3D=3D
static int srp_map_finish_fr(struct srp_map_state *state,
                             struct srp_request *req,
                             struct srp_rdma_ch *ch, int sg_nents,
                             unsigned int *sg_offset_p)
{
        struct srp_target_port *target =3D ch->target;
        struct srp_device *dev =3D target->srp_host->srp_dev;
<...>
        n =3D ib_map_mr_sg(desc->mr, state->sg, sg_nents, sg_offset_p,
                         dev->mr_page_size);
=3D=3D=3D=3D=3D
After that, mr_page_size is presumably passed to ib_core layer.

=3D=3D=3D=3D=3D
int ib_map_mr_sg(struct ib_mr *mr, struct scatterlist *sg, int sg_nents,
                 unsigned int *sg_offset, unsigned int page_size)
{
        if (unlikely(!mr->device->ops.map_mr_sg))
                return -EOPNOTSUPP;

        mr->page_size =3D page_size;

        return mr->device->ops.map_mr_sg(mr, sg, sg_nents, sg_offset);
}
EXPORT_SYMBOL(ib_map_mr_sg);
=3D=3D=3D=3D=3D
Consequently, the page size calculated in srp driver is set to ibmr.page_si=
ze.

Coming back to rxe, the device attribute is set here:
=3D=3D=3D=3D=3D=20
rxe.c
<...>
/* initialize rxe device parameters */
static void rxe_init_device_param(struct rxe_dev *rxe)
{
        rxe->max_inline_data                    =3D RXE_MAX_INLINE_DATA;

        rxe->attr.vendor_id                     =3D RXE_VENDOR_ID;
        rxe->attr.max_mr_size                   =3D RXE_MAX_MR_SIZE;
        rxe->attr.page_size_cap                 =3D RXE_PAGE_SIZE_CAP;
        rxe->attr.max_qp                        =3D RXE_MAX_QP;
---
rxe_param.h
<...>
/* default/initial rxe device parameter settings */
enum rxe_device_param {
        RXE_MAX_MR_SIZE                 =3D -1ull,
        RXE_PAGE_SIZE_CAP               =3D 0xfffff000,
        RXE_MAX_QP_WR                   =3D DEFAULT_MAX_VALUE,
=3D=3D=3D=3D=3D
rxe_init_device_param() sets the attributes to rxe_dev->attr, and it is lat=
er copied
to ib_device->attrs in setup_device()@core/device.c.
See that the page size cap is hardcoded to 4096 bytes. I suspect this led t=
o
incorrect page_size being set to ibmr.page_size, resulting in the kernel cr=
ash.

I think rxe driver is made to be able to handle arbitrary page sizes.
Probably, we can just modify RXE_PAGE_SIZE_CAP to fix the issue.
What do you guys think?

Thanks,
Daisuke Matsuda

