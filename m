Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03074E6756
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352020AbiCXQ4Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352039AbiCXQ4C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 12:56:02 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABB17C798
        for <linux-rdma@vger.kernel.org>; Thu, 24 Mar 2022 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648140789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kNr3wrBW5rdRC+nlzc1lenCFCUy3Y2qf+Z0lHhPi6A=;
        b=ASZWwdBgfHk2jEA0S/HoRbqSDHgsUPlR4HbgZemMfkUhBzWKCwdKGmn4mWP6TnY6tcAiRT
        uDvGzhoLnjRqEusEwRAqBWgiN7mE5H/tMy/JcRU9XFOQhQRA1X+BAGaegz6qn71ppxaWFd
        L38vrD1tWAyAL+rPyBulnqEHi2NQ8FA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-7lRxbKGkNUGA8f3cSWr0uQ-1; Thu, 24 Mar 2022 17:53:07 +0100
X-MC-Unique: 7lRxbKGkNUGA8f3cSWr0uQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3OdiaDMi7BNqgQWB2ECLhmJSCUr9boe3g/JEndH6gWeJQ12noN7N4z8zcKrMo+WEMJSXMqs1SKPAeuv6UTrQz3xrknhvdvJJG7mPURelxsTtjODsVsyym0Dz/JTh/OpayTKVz0zoIfMAiXemhG0UOlRNM2YnTZmhP2mB4xmypEWnKDWaz5HOz0hbZEPjxGQIH2sEptQPUpKllusSyvvZw5+VvWeQnYX7rWQhLfhKCEfbga/gXg7WzpbHKrkXRFq5X4vlM+sSfSbJs2hmKnp5xZyWfuI1am5J361qyl6nVs8pE2cSTpDJhhmzBqVan0bjHnY8XgNVctZ3mvCbJOjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kNr3wrBW5rdRC+nlzc1lenCFCUy3Y2qf+Z0lHhPi6A=;
 b=aiSvCQDNyzDuxFvMTLu0QZMkBSuWMch7Fhgn3NHKw4UqTsZNe7fYEqE23gZWib7la7J4OqXlsULuFc3qtGI+iHVKJuMhbnQrwlZfr3duKZte+fraASkNKutbE9LhQCz+wiRcF45W4enRxYeQ9av7GEtxbUAUjbmpZEXwx+ysurhWCgfmB+UB/L0ny0QsJmrriWzkChtRXAaeTv6Ts/qG/KjQncVefhTgR1MD/O6LWnN9PfwBgDfwkVO8njbUZCfuBunYHdvHBpXtMF67sTPFDRTSUGfg0ipx3yui3CDEbgPWVph1wUe4x40vomGIzma1uSc2mPs7GysAnCQkDin+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB4284.eurprd04.prod.outlook.com (2603:10a6:5:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.24; Thu, 24 Mar
 2022 16:53:06 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::744e:de45:69f1:6fe5]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::744e:de45:69f1:6fe5%7]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 16:53:06 +0000
Message-ID: <0b7b4805-5f07-fae3-3692-75cb5ef5060c@suse.com>
Date:   Thu, 24 Mar 2022 17:53:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Question about v37 and v38 minor releases
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        "Latecki, Karol" <karol.latecki@intel.com>,
        Michal Schmidt <mschmidt@redhat.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang Li <honli@redhat.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.de>,
        Benjamin Drung <benjamin.drung@ionos.com>
References: <DM4PR11MB5549E169E3C06766D347A936E7119@DM4PR11MB5549.namprd11.prod.outlook.com>
 <DM4PR11MB55492CF07DCC8105204D39AFE7119@DM4PR11MB5549.namprd11.prod.outlook.com>
 <DM4PR11MB55494BCEA81DCEB6FED81834E7119@DM4PR11MB5549.namprd11.prod.outlook.com>
 <YjyEDYtw7Rrf2JfB@unreal>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
In-Reply-To: <YjyEDYtw7Rrf2JfB@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0112.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::17) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0758039-ba2f-401d-5472-08da0db6c466
X-MS-TrafficTypeDiagnostic: DB7PR04MB4284:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB42844D00ADB5B1E9D1DF917CBF199@DB7PR04MB4284.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNvzfvJw0YQu1xLgLv3/1Jtf4Ztmb+xg6i67T3wQrIy+3HceoysNDCK8HtiQ0yQyi3vJNiUhj1glzNNOi5VfEYqUczj38BQo0MiVG/jXTt+DlwMURlbY82lLZhCtG43dafHMv0Tsf/0VCKAvBhvxhqmShx9nh6vdnOOV8SuZ+2AVKy/BovRWMIgvam6Gg1nDZKE2mX0Bc3hX7g9t9WyjTMRjJwWhNjGIxxHHZxEzSNWQSJKvO09dt/Wt8nDSy85aOOG4wf7E4ROf/OxI+Va5FU+tk02jroUcWsv7T9031S2mmS5IvZji5AOYUrSOjGe/s1x9DSBQkSqQ7UdL2a5zAuI22KgXRCg7O9suDmZXFAsX5LZDBANaXLAFTfeghFnX8tahpNSqUjZP9fI4RfkSostS8mcfJ0mYVkCqByUVAutfDJnrQyXIV+jmDamRuR+xpd/kiAzsMzffSSUlfm5qPBbeT/b3ICw7ZmJEY8rru99Is6e1v5mA1ZPpuFuzlUsGu++/ltEGvq71WKaFsa3JzwirwwLB6Sm0TIKW6Tgn9FZrwce3j8uwqeXuhpiB7LlS2/Qmz/19hed6mAAuy9YQ3n487HefKwHamcZHr2d6MiNw1wreRf3ZUu4RXyUQaWRRhCp+eYO1VeH4XhXZrA2qvjUu/RdLzMx70ATpGC3nNfXj3rImqss+41ildAReQ5Iv4tTv9xdM+UFsC50SX66fNy0zibbnNwSJOTQ7IrRVbZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(316002)(110136005)(2906002)(8936002)(54906003)(66946007)(38100700002)(66556008)(5660300002)(8676002)(66476007)(4326008)(53546011)(186003)(6666004)(6506007)(6512007)(26005)(2616005)(83380400001)(6486002)(508600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU5qSkZpbVhQdUpQNVB1c2wvVy9LeTE2cHdvdFBqSStrZnB2MjdwTW9SUXpJ?=
 =?utf-8?B?MG1kZXU5WGt0Nm0xMk5GNHRoOWVBVWtXcG5wR2g3b0FFNWY4bkkrUXB5YnhD?=
 =?utf-8?B?RDZ6czhhc2FDN3hVL1ZLalpDN1RwYUZoOHFSeVhhY2U2dE1wQUljUFVKelJl?=
 =?utf-8?B?aTJNNTRPY2d1Y0p1cEg2aXNIVC9NQjVPTlI0Z1ZDakxZRUlvZVVsSlpybnAv?=
 =?utf-8?B?SHo2Sm8xNDFhYlVkeFVhZ0RpcURWbXBUM2J2WWNvRVd2K3FLNmdiWm0yQ0tn?=
 =?utf-8?B?cmJJMCttRTlaWWE0OWZPaC93R09tR2NaRDltVU94YkxVKzlZQ3BveGtXeHhr?=
 =?utf-8?B?RFdERFlqOEdCemU4V1I3TFgrL2NwQ3NHTTZjRXd0QkZrWkQ3V24wQy9hR3VT?=
 =?utf-8?B?ME5FZmhqRWdpanBWMFVUcDI1SWNKN3hsNGRMeUFQNFVNd2hlQjZHMnl1alVw?=
 =?utf-8?B?RjQzZmZWQ1lHVzliTlJmTjVlR3EwSVlLcGlWVXFZUkF3STlQYXpsRzhWMUhr?=
 =?utf-8?B?bW55aDZtcjN0QXUxQnZuMkhPclI5RWZ6UTYzNW1iMm5GQ3VQVy84ZWVSY3ov?=
 =?utf-8?B?RmR4cXhOOFRKNGFzQnVJU1ZyNlErU1IxSDBMdmRLQ1IrUk1wTUZSUUNrR1Yx?=
 =?utf-8?B?S3YxdlVpdmtwUnZiTXp6OXhWT0F6anZ0YXArc0k2QlRRRmlVanRCLzRUTTFi?=
 =?utf-8?B?eHBLRkZYbVgyQUppWmxoTDBhMUhVN2wxNWdGN1pBMkpsSHBGSWlLWEp4MFpY?=
 =?utf-8?B?clNVRExhQlJETG1aV0cxTWp4K1FlYk9EVWtXcmNsTVg1QlIwNVpkeDFIOFp1?=
 =?utf-8?B?V0c1bDh0NmZJUkNXVEhDemRCNzlFaFlpazRmMjJ1KytQQmdYNjhyUk9raG1Q?=
 =?utf-8?B?d29wMDRvQko3M2VVaUJwQkZWb0R5ekRiK0FuUzIwNHA2WXNWUXRkYUhpS1dQ?=
 =?utf-8?B?TVFvNXl1V1hINFQvRm15Z1h4RTB2OExmQlA1Yy9Ja3JKajNFM0JuZ0N2Ry91?=
 =?utf-8?B?aHFxOWV0cWE5ZUg1bUtkUnZSWFI2d1EvUGRBN0x4Zm50Z2R6dHl3U1ByRU8z?=
 =?utf-8?B?bW5ybDczeUUwekt0c01SSE96Tkt1WDk4eW5GWWpROGE1MnYwS0p2U1Q3aFRB?=
 =?utf-8?B?a1VLdjg5M3pxb3ZpdU53dE9LU2FsbW14bGdBYnJzc2g1NWtQYkZqZDIwNHRF?=
 =?utf-8?B?ZUJBRkpVaDBGWjVreitweGswL0VxYzJZVDN3RHZabFhYUE5qR3N1dHdGbDc1?=
 =?utf-8?B?emhGbU12U2NGKzdRRHRuTnpMaktPb0NWWGtEaTVuWE03QWdBUWpmSGl2d3V0?=
 =?utf-8?B?Rm9JMGhwQ1llWE12VTkzR0NhSVJZSmxjM3I4NW5HOEZkcWphNmZ2TDFsWDhI?=
 =?utf-8?B?TE5sNTdyTEZtUTBtU3BzT1I2Skl0T1F3L1o3MnNyY0hRVWNzQkEzQTRSemFw?=
 =?utf-8?B?N0F4a29KOWxHMS9jRVVEOTBsamRLZ05jcXpUTThjdkFWMnNvdDdoTWd4OFBs?=
 =?utf-8?B?cGExSTg1eS9tY1FESFBIOWlUdU5kTkVMaTJMd2crNUZJTGVuc0FKNEttN25a?=
 =?utf-8?B?RFU2bGhFWjNZc2x5aFpLMmFuUWFIQlVrNEExOTh3NHBqQ2VqeUhmODlxUkFC?=
 =?utf-8?B?ZTdhU25qQmYwUjVYWkREMTl2ZjJKamxpb0RabUlzUHpkaVpsWGhTSGZlWk40?=
 =?utf-8?B?U3NxZC82ekxQQ2FwaTlVdytxaXI0NkJXYVJRT0ZWUnowVzh4aWYvbjNZMitl?=
 =?utf-8?B?M0YvT3dsK2dvT29YVzFNdmZFNktKaU5ScHVNaDJVMk9JOUsxbXgrQ1RFZGY4?=
 =?utf-8?B?emZ0OG5RSVpscWhYVVhlUDNaSEZYd2xTRTRBR2NPM2pUSTNCK2FOTFR3MFMw?=
 =?utf-8?B?UW1jcVBuMFFyTEUzWjQzVUhkUWtMTFdMWjlaMzBLaHhMTFR0NmVwWGtZKzdv?=
 =?utf-8?B?MDlJd29MRjV0R2l2T21ObExBR3ZSVlFSUnFZU0hwSEVtSTNabWhYaGZ6OFpQ?=
 =?utf-8?B?QWtla3lmRDh3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0758039-ba2f-401d-5472-08da0db6c466
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 16:53:05.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM9LFc0bY/CiGLx6zkeS9pLRwV049kNDdY22GuPKck7L2Pdh846NjB26UTn2gWKzILacsaWRlJ67ISZEs0f6xfqTH+k0+6/LPUK6YwTzcAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4284
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi

On 3/24/22 15:45, Leon Romanovsky wrote:
> On Wed, Mar 16, 2022 at 09:34:19AM +0000, Latecki, Karol wrote:
>> Hello!
>>
>> I would like to ask if there are any plans or ETAs for rdma-core v37 and v38 minor release? Our team is waiting for 4c905646de3e75bdccada4abe9f0d273d76eaf50 "mlx5: Initialize wr_data when post a work request" to be upstreamed to package repositories like yum or dnf.
> 

Upstream-wise, I'm just waiting for a fix and can publish a set of new stable releases afterwards.
Regarding yum/dnf that would be Red Hat responsibility.
AFAIK, Honggang is not handling rdma-core for RH anymore.
I've been told to see with Mischal Schmidt <mschmidt@redhat.com>.

Nicolas

> Usually request to create stable branch comes from package managers itself.
> 
> RedHat - Honggang Li <honli@redhat.com>
> SuSE - Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.de>
> Debian - Benjamin Drung <benjamin.drung@ionos.com>
> 
> They manage rdma-core packages in relevant package repositories.
> 
> Thanks
> 
> 
>> Apologies for low-importance question, but I did not find any road map or other communication channel on rdma-core github site.
>>
>> Thank you!
>> Karol Latecki
> 

