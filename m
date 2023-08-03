Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D147576DD29
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Aug 2023 03:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHCB3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHCB27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 21:28:59 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC530C2;
        Wed,  2 Aug 2023 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691026138; x=1722562138;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=z/OHcptydWrx6i9Drdad6H8eh46V3u4OeozFFd9BppE=;
  b=NMXjSUBp73dJLCA5hNE9LsjLy2TQFac9m2briNCo1LDfXio96ifltjH2
   KBcI954aMU69PnUd/AwedXr4TVgsC59tAqLhJSpg+iRilwtg3xFSIJeo6
   SKDDz4xw6X9a1CvqctvmYYFGvdEGTivzYbFphhTe4khyKPE7h+geEOk1r
   uRVSuiHQTnK0VJJTndPPvKWfBMUVjj6IHPPL/3DLRaEyPiLVF9chUmyVA
   58x9J3CWo329vMrM694LTVDaVXpWSTC0bPXX3CSdvwOIbXsinZIUs6xcm
   D/n9oqOTzMo01LrhRecVO0q5ZQmaPKzULpCiL3kqk+Vqh8GljCkX5UyTw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372476578"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372476578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729353887"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729353887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 18:28:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:28:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:28:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWtbqSSyRQDQGP7Pro4Jm05VgfsNaiq32f8bVIWGGhVIcSy56h6CHpux7jkHg/FkMUqxAbl5Y45H2XxwOxhUIloe6xvpk4TiIYDsfOUSHlnf0BV/pyFvD2D6LHqTrfDQB1IJd37vEoSOJcpJoFRyDwqGbnCpGrmXYEDAi00GYZEngHORC6sfiRqHFA1El7mORAukB+rh1Wio/FFsX3vwHk8vzr9sV4ezqoPZJ8rc8BYj/E6HJeGoiXMGjHKth9OeU0NUkdLYCyEf4G6u1T1MSsfdPUZrcUVzWQ22kO6mRNcRVwSQgebfHuM/erLHr/jmq8ltKD4HvDLytUjgQezxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCMwpoSf5PGfTq1yOe2wFv3eEo/0LwxwQHZrRkta3vI=;
 b=OO44BP4NsXxSzmeV+G2i6JpDY6flSc2bx/Odyr8SQc+WbuPN0x90+uJgzLRf9rOlOR+9G67w4HZt970BYuZeIpHf40/7+2hPZjOpM08TwWmqV6c05dhIbF0AnXFRws2TsGmhHiLLnr6NQKxOGMdeqCEaVPHiGz1TPZdhfIORMILbvkNFC2K5BsbDC8TcCl+X7bWjgC567jIGt3tuLvAMHVEHT2ggr4pN3Vddx1Q8I4d6kYfjIYJF70dZ/c8P5+Yz63b0noKeUZGB3jGNvRLHH5E0ck4FD12UoTvriKWpe9Uu+53YMeAO/5Bu0BTScZc008X1admK6SEvtDnbQcmxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 01:28:50 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:28:50 +0000
Message-ID: <c6787831-aff3-9d82-93fb-0140cec07db3@intel.com>
Date:   Wed, 2 Aug 2023 18:28:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, <borisp@nvidia.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230801123854.375155-1-ruanjinjie@huawei.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230801123854.375155-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: ec61847e-eb5b-4411-1eaf-08db93c0fd67
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVoAzTu+O3zbxTIk0712xLWU1G1tEx5T9x6r0UZkJ+rd4mO8VUJtMfx/i5aSbXdi7kMch3UYgHOzfT24AbnPBL+vKpTwE2JWBoGPmPex980uBHcZsMHUT4mX0lgnAFg6a4mH9cxZiFj+A8NySw1qdS6PF4+p8EHYGGKcDga318YihgaqPJBB4ryhzN8D2uM5pJhFha49PdTpxrmCUP2LcLngB5AtaN/EG/Dulov9FvnyQx+qEXs/pMZF5cQYJeMGguSXIHcoh58mxgXyxcWfcmBu4xNDhxdrBB7z2R+Im0KbuLJc0k007AT1seb9z+6RWW2JCjUTb/fPh859vn/Uo0B43MkLoV+aiMXO3A7IRRNH7OCtWdHcsnkoHhe6uNsghoIwZzSkSmaHdzQLtGy+oWRqlee4jGpUh/tWhLIIIeTBf9xLO7Ml28JCdMckTbIDRWxjpbkBExGEBBAnQsbBOa/BLrJXdxaMHJk4sfc3k+vFMaYDzGsy9NtX6BTo8jLGAOM+6OmFv6yBO/4CwhMx0pxOqWPd26LCKIHUT2OcXAMtfu9hzt8lXK1l0sKJsePGmCPDCJxGgKfsVH+W9afDELp2KLuAY1EKVI/qRvI7T1LOZHKUa07++j2uFjlodcwwXn2GcHzXUglJds+cAFhEqXHj8FqjahC0qCdZOIuNgVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(31696002)(86362001)(66476007)(66556008)(6486002)(6666004)(6512007)(2906002)(31686004)(44832011)(36756003)(478600001)(38100700002)(41300700001)(2616005)(82960400001)(921005)(7416002)(5660300002)(8676002)(8936002)(26005)(53546011)(6506007)(186003)(316002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9WWnhGNmdNaitXUThNNit4WWwxNVBGTS9PLzMxZnhaUVIyQUpBZ0FCeDR6?=
 =?utf-8?B?Vk9iMmI4djBFSDJsYzNkNHVvTXpSRldEeExHQXhBanAwQ3Y0VFh5ZWRTNGwz?=
 =?utf-8?B?UDZjK00vUUl0VGVwdTFYNDJzQmR4STVJNGJEb2dhajdkOVpUSkNRMExIeStq?=
 =?utf-8?B?bjRiS0xmbURialYzRGcwWGJoek1vL3VzMWI0NHVlSm1yZ2V2ZExLbldTOUVD?=
 =?utf-8?B?TFhMYVdVRkNmSHlUZWFzUTRiRklpeHk4RjZBMnZTbEQ3L1NZWGJpZjlIRkZa?=
 =?utf-8?B?VHZDUFBoejNmdGkwMWlhUmRoT3M3YytzbzR0ZTFwbDREd3NMMHRrd3dTSmFo?=
 =?utf-8?B?MlErMUZiaVlQajhzOUdBYTh0UlJ2WFJxSlRaSnVnNGNtSzE1ZmU0SFZCUE5o?=
 =?utf-8?B?OExPdGZRUkhrMU5oaFFGVmZMcjJUZ0NaTGdySWxRWVhOVkxGWExOSWJtWDZP?=
 =?utf-8?B?L1A1WnNLekExeVF1T0xwREJVMnJtM1U4T0tUbXJ3Q0doRGNka0hGbC9LYU0v?=
 =?utf-8?B?T0NxR3Q3WkJyUDIyVHZNVzR6Tk1XamJlbWdJTXF6NnUyMG54WVozcEc4Wm9h?=
 =?utf-8?B?VXArc093U09YQlQvWHlFRng5Z1VlVW5WN0Z4S3lQWDMxWUFITVZ4elhiaDJt?=
 =?utf-8?B?VVM0NTJnTlIyZW00dVFBQm5HZEhXdkwyK3RydVBsRGc0VWZFZlFPSHNGSjZ2?=
 =?utf-8?B?S0k5MnhYclA5aGczZUZJdEExRWNnTDNDNEd3b0NqMUIxMUpOMjdhVVd5Nmsy?=
 =?utf-8?B?WU9Mekhwd1dHRkxKMjRpUFpRRTUrdyt2L2IyUkdpRmFCbDdGN3gwSTVwUTk5?=
 =?utf-8?B?WDNCb2lNckYwMDdMVWtBVFE2ZDQzMC9vMGl0R21TUzZFM0JUWk4yeWpNNXdq?=
 =?utf-8?B?VW1aZytmWG5ObWxsYjExTnp1bysxeE1BbVpNak5uaFdmTENDbm9qeUZReVEz?=
 =?utf-8?B?THpwZG1YTk1QM0I5QnRXeFVZWjJPNkhONXRxT0RPTWViNW9tVE1QN2NnOURn?=
 =?utf-8?B?Z0tSR2srdEJmdE02dWNqUUxLbnQ1eHI1YiswRFRsNm5wVThDVWlnZE5JcGp1?=
 =?utf-8?B?cXRCOUF6VjZNRWpwN1dONjhDeHhJMEorRE8vU1JCbjNFdTdVWjQvRi91bjF6?=
 =?utf-8?B?QlZzVC9HaWFvRnJMSWE0UERkR2RKanJidVhTQmtoL2M0aTRidkdHSmt0cUVE?=
 =?utf-8?B?U0w4dS9UWUZyQmZRSFVaV1RMZkh0VnZ4TCtWSVpNQnU2MThkbVFtajVJYXZ5?=
 =?utf-8?B?Y2Y3a0RCM01wcEJSWGx5bVNaOTk2VnF5SUkxQ2d4V0NNMGJPSXB5WkpXbzJn?=
 =?utf-8?B?d1lWbU0renQ2d3BkUitXMFRnV3VJQlhpY2tSUi90M1p2djQ3cGIveEM0N2Yw?=
 =?utf-8?B?blc4OTM4UFBmMUNOWXNRUDQ4SFl4WEhSSXJBMmxTT1BWM25GeTJMeDY5bVRm?=
 =?utf-8?B?aXNVSzJnanV4SWNRZ05EZHVZbm5RZ2VrME9IbWFtQ3d4UkR1R1Z0cFNIVENp?=
 =?utf-8?B?Uko5VnFUaUZSWUxNVHR0OUpRdlJzWW9qSEdicUFUQXhLUkhMeUF0QUdsaFRv?=
 =?utf-8?B?cDdjMWVZWVBaVzdTai8vY2xkSFRQUkpmVnhPdjNTc0lST1AyN2U0dmY4Skkz?=
 =?utf-8?B?Slc4SmplYTBFdnp4akw5cFU3ejhGR1EzZkladUpEQTFBaXE0SDJFL0JOdG5p?=
 =?utf-8?B?b2VuVUE5bS8yTUdnR2dUTm5hQVBpY0FWOUowdm1LMGczNFlRSXdnWlFQR0pX?=
 =?utf-8?B?RHJqOXdMQ2ZKejdJMndQSXgvRyt0RVpZRkpyY01qVDRNeFJoOWJsZWprWGVW?=
 =?utf-8?B?YldLOXRFd2p4aCtaODZSRTYySmxUUm5yY0VXVzdzRmJvbFNMeW0yZkhwUG44?=
 =?utf-8?B?OWtUNXhLOWhNR01ScFF1b2o3U0JsSjRLcC9Za2lZYlpIT2Z3TmhjdldwNU1N?=
 =?utf-8?B?bWRqeXBKL3dRaUZLc0dhRi93bXd1TlVwUVBOZkF6QzNCcE92aVpFdUxhNXgx?=
 =?utf-8?B?QkdOSXNON0pYUnVCMlRxelFrcFJvc2JUMzNUa1pDVWZTQWdnaU5DamZseHQr?=
 =?utf-8?B?ZUt5eTJFeHEzUEV5UGQxWk11RzNQcmZiTXhUR2JlSCtsclhCaXR4aHVybGdL?=
 =?utf-8?B?UkdjU2ZFaVpnK3JHVVJuMGxCQnoyeFA0bHFMYWEzSVhkRnlyd0RKUFJWSytv?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec61847e-eb5b-4411-1eaf-08db93c0fd67
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:28:49.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk452NXns0O3WHB+N7q03haYV7fXMgZ5RkJHrfKhjszkKvkRHky9MHoAW02ObVaMjhX7LMvNX6tP0c9qnqskP8QpvOyFkSa+wei30Mox5fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/2023 5:38 AM, Ruan Jinjie wrote:
> Ther are many pointers assigned first, which need not to be initialized, so
> remove the NULL assignment.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

I went deep on this one and double checked all the changes, they're fine.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


