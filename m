Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544FE1C9B38
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGTgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 15:36:48 -0400
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:24628
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgEGTgr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 15:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkWCQEPtC2Wjvn565Qk2JTUvo5AQGiyse4xUqH7j0EeKAzk+jtl4exPE7D0UKhUCbt986o86hEaFjjO+T0RKnRK4oDM9zSYybOoAZJT5ltbFK5hOW3IGH/n6rQXE26MIyVFvejYSD4H6smf0lcvTm6rkIgTIt8YbtB76dYn5jaj9s62GpgeKS+WpSvGWFc7upK+XUWZUbCyzm+MMBDSFR/VQllD2fEWsJ5NWNXZ/7tVl0iH4Rk1a3aVnh4LWpkaaSTGLPCFO/l1xp0fnZ2V0SqshpRaFmbpB8o5SE64Nolh52VQEK+dZEbh4Q8yjFDZqjH1oGQvQeQtfTXGYr79Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7reEpw2rjF+gYK0ilYxn3OepFDYSFtwLgDf0d9+Hs=;
 b=KYhPy4Aut4YBuGJi/4lqtcCowToc/gWyF3SGY4wMw96ZKv+knVEcp5uXNQfXUf9a+TV+49iHuQhnXTPg+1vvFmoXitnQK1xZ8oJCsy6Ac51FaEWldQdyLHafhv7RlZEW74FlZxWVAXRcdNCnxuurAZ11g2jkUfP1TL+19ZuynbPLmzqV1sljvvBNJaC5MioJEOfFpbrDAwB3uIuK/q/heQOIFbBjwIiorfGe3OVqEA68p9s2OYnF2azJNa8oIyPckTBc6qxBdlRjG4sEbYyijTu86vN6oK1I/Fl/Y0xDaxoATPYlZWH1sNsGZ/DHOey5xBTsuN2uSkfn4vaAd88hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7reEpw2rjF+gYK0ilYxn3OepFDYSFtwLgDf0d9+Hs=;
 b=rDH4p1jdcD+4KmYrWo/WNLI9qQB4wjEQGx+gi4pgOHhvmdK5VdU/edxAC6pEB8NyhWljlbahwpEpxmUZY0WeD7XMfPlqEGTtViTgNn/gKzAeQOSnMX4Zr+9GkPBJoqwWG7NASiAA67W6cWwbtnJim9Mm7PEINWF2eGsloPPLSMA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (2603:10a6:802:1d::15)
 by VI1PR05MB5213.eurprd05.prod.outlook.com (2603:10a6:803:b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 19:36:39 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4d4d:706b:9679:b414%5]) with mapi id 15.20.2979.025; Thu, 7 May 2020
 19:36:38 +0000
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
To:     Divya Indi <divya.indi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Kaike Wan <kaike.wan@intel.com>
Cc:     Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <7572e503-312c-26a8-c8c2-05515f1c4f84@mellanox.com>
Date:   Thu, 7 May 2020 12:36:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.33] (104.156.100.52) by BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 19:36:36 +0000
X-Originating-IP: [104.156.100.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 806ff1a3-c68b-47fc-a20f-08d7f2bdf5ee
X-MS-TrafficTypeDiagnostic: VI1PR05MB5213:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5213CD942AE5E46BF4C8ADB4D2A50@VI1PR05MB5213.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngmNaae9yF65V7nrPqoEO5O+UDPtMEUQpq/8tiv8iCPU4/15H8VjDeZ8a23x1S57Hl8Y23CeIPFp3kRzX+12pgbGx40YDS1LxPBiRDTZ0Ar2wG5gdj5bZ6PzMFxwUI1v/jIVjDVqJToVzAnlSih3aNBbj7TN8i0661csuPNWuJ5vNT20WMUeDQ/F1vl2ZCJaIzyyTpyx/4mp6XRM5Uq+IRNWScpPepw9iBd4k75+0z20JThs2VxQpVEQYcOul9FF6cFjl9wjBQz2JPYPtm8fys2BQ7bOEYS5cuUnRL9eiamd4kscjy9N3paqHOuAG+62RGMBe4TnPHrGLIbzekF/mxJqwDcjg432xfPx8vFq3aj7z5NV89e82ajiyw3tkXnJgbKBXSqaatG8kfaOCm/aOYmySuIvcAFzGWs45xbzy1Ovz4J7Mt0oIeyj9urkimIVXbYtITRYIJ3Vp16EIx6tyjk1R8JPzs+5ui2ss7HxY48Gf0r2pEG/GH5DjBLyvayxXo8eQPyaic6GFwiMoDfcktZyIvlhtXRjoCDFVoGwV40w9wj858Ve0kHhw27ge8bZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB3342.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(33430700001)(5660300002)(8936002)(8676002)(31686004)(26005)(53546011)(2616005)(16526019)(186003)(36756003)(956004)(52116002)(6486002)(66476007)(316002)(2906002)(54906003)(16576012)(7416002)(66556008)(110136005)(4326008)(83320400001)(83280400001)(83310400001)(83290400001)(31696002)(6666004)(66946007)(33440700001)(478600001)(86362001)(83300400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dxCp8MiwNWB4eKQ78fj9v9svLf82mqnyIrf0qJrDER/w388kGES0bCmusNHfeu3O36+CiYE6fuBiZFUigFOfmvy+Nfv+7/i6XS7Ljrnn4PvPVBWLYO5KzuQvXioaUFgCxep7XU/Bm6dQxlsKDFjgmzHLqmyixif7LBG/j9gy7kQpyx4fjec3cBGg2WH2xIJW/cRXGNODRn91vFdh2hysHw29ynLwUrCjbDI7xe9eou/ZUURClzNWOCg1JBcua3nSE0Ueq0iJo/FhZmR/Hbg8kiKvQumIDgBMqT81ShIAfVVtOg40PzYd//cICkFHy2hQyf7DmnDGAQEzTHe2r3v7EnJKux++Yx+EQIEqhTfGoK1bub1jrJtdWeJ8WX6Pe53zFFl2XtLS3igKvxRJ2LKjZ9pHxpSS2xJIRgQG2GCdpXGwlLnxEEaOHq38DcsgKr7d/aKcCORn5SHKDqnscGR202pgAgSI2CGZf//Qe7Pv0WlV7HCgCdvqjjZNMrnBcNrgZjCSHFeR1mdy/BaBcdz3cEUa1fFdZDWpTBx8gSqND068BCvn5zWYatUFAOUpR+Qe5LY3qEy0LNE/u081nzQ+m3OySlboUvzPV4+ct2lu73BrsgB7EGnkFO326MCqUXweAq/KnxHKB1nJ6mCNhoxQkupPuB5otQRXWeDsQObo9sPCDSMyADabvU5ASeOuArVbFIfc9i4ZOr/bZMYQwhhlX6YvZ5T+dtVt8TmY3DxPALx+Ow98o5s31QHLQh37uFrPlWhhaQPER6Xej58oeNOxczTxrPBYSc0/20giSPtRx0g=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806ff1a3-c68b-47fc-a20f-08d7f2bdf5ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 19:36:38.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBrNkKpMmPq5W60B7xcfD/tUWeg4ayMfVK/NLdQLxRNxFHXaauhsgwafLyT/wfo3rnD08zuF5dI56ucYT/T1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5213
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/7/2020 11:34, Divya Indi wrote:
> This patch fixes commit -
> commit 3ebd2fd0d011 ("IB/sa: Put netlink request into the request list before sending")'
> 
> Above commit adds the query to the request list before ib_nl_snd_msg.
> 
> However, if there is a delay in sending out the request (For
> eg: Delay due to low memory situation) the timer to handle request timeout
> might kick in before the request is sent out to ibacm via netlink.
> ib_nl_request_timeout may release the query if it fails to send it to SA
> as well causing a use after free situation.
> 
> Call Trace for the above race:
> 
> [<ffffffffa02f43cb>] ? ib_pack+0x17b/0x240 [ib_core]
> [<ffffffffa032aef1>] ib_sa_path_rec_get+0x181/0x200 [ib_sa]
> [<ffffffffa0379db0>] rdma_resolve_route+0x3c0/0x8d0 [rdma_cm]
> [<ffffffffa0374450>] ? cma_bind_port+0xa0/0xa0 [rdma_cm]
> [<ffffffffa040f850>] ? rds_rdma_cm_event_handler_cmn+0x850/0x850
> [rds_rdma]
> [<ffffffffa040f22c>] rds_rdma_cm_event_handler_cmn+0x22c/0x850
> [rds_rdma]
> [<ffffffffa040f860>] rds_rdma_cm_event_handler+0x10/0x20 [rds_rdma]
> [<ffffffffa037778e>] addr_handler+0x9e/0x140 [rdma_cm]
> [<ffffffffa026cdb4>] process_req+0x134/0x190 [ib_addr]
> [<ffffffff810a02f9>] process_one_work+0x169/0x4a0
> [<ffffffff810a0b2b>] worker_thread+0x5b/0x560
> [<ffffffff810a0ad0>] ? flush_delayed_work+0x50/0x50
> [<ffffffff810a68fb>] kthread+0xcb/0xf0
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff816ec49a>] ? __schedule+0x24a/0x810
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> [<ffffffff816f25a7>] ret_from_fork+0x47/0x90
> [<ffffffff810a6830>] ? kthread_create_on_node+0x180/0x180
> ....
> RIP  [<ffffffffa03296cd>] send_mad+0x33d/0x5d0 [ib_sa]
> 
> To resolve this issue, we introduce a new flag IB_SA_NL_QUERY_SENT.
> This flag Indicates if the request has been sent out to ibacm yet.
> 
> If this flag is not set for a query and the query times out, we add it
> back to the list with the original delay.
> 
> To handle the case where a response is received before we could set this
> flag, the response handler waits for the flag to be
> set before proceeding with the query.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  drivers/infiniband/core/sa_query.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 30d4c12..ffbae2f 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -59,6 +59,9 @@
>  #define IB_SA_LOCAL_SVC_TIMEOUT_MAX		200000
>  #define IB_SA_CPI_MAX_RETRY_CNT			3
>  #define IB_SA_CPI_RETRY_WAIT			1000 /*msecs */
> +
> +DECLARE_WAIT_QUEUE_HEAD(wait_queue);
> +
>  static int sa_local_svc_timeout_ms = IB_SA_LOCAL_SVC_TIMEOUT_DEFAULT;
>  
>  struct ib_sa_sm_ah {
> @@ -122,6 +125,7 @@ struct ib_sa_query {
>  #define IB_SA_ENABLE_LOCAL_SERVICE	0x00000001
>  #define IB_SA_CANCEL			0x00000002
>  #define IB_SA_QUERY_OPA			0x00000004
> +#define IB_SA_NL_QUERY_SENT		0x00000008
>  
>  struct ib_sa_service_query {
>  	void (*callback)(int, struct ib_sa_service_rec *, void *);
> @@ -746,6 +750,11 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
>  	return (query->flags & IB_SA_CANCEL);
>  }
>  
> +static inline int ib_sa_nl_query_sent(struct ib_sa_query *query)
> +{
> +	return (query->flags & IB_SA_NL_QUERY_SENT);
> +}
> +
>  static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
>  				     struct ib_sa_query *query)
>  {
> @@ -889,6 +898,15 @@ static int ib_nl_make_request(struct ib_sa_query *query, gfp_t gfp_mask)
>  		spin_lock_irqsave(&ib_nl_request_lock, flags);
>  		list_del(&query->list);
>  		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +	} else {
> +		query->flags |= IB_SA_NL_QUERY_SENT;
> +
> +		/*
> +		 * If response is received before this flag was set
> +		 * someone is waiting to process the response and release the
> +		 * query.
> +		 */
> +		wake_up(&wait_queue);
>  	}
>  
>  	return ret;
> @@ -994,6 +1012,21 @@ static void ib_nl_request_timeout(struct work_struct *work)
>  		}
>  
>  		list_del(&query->list);
> +
> +		/*
> +		 * If IB_SA_NL_QUERY_SENT is not set, this query has not been
> +		 * sent to ibacm yet. Reset the timer.
> +		 */
> +		if (!ib_sa_nl_query_sent(query)) {
> +			delay = msecs_to_jiffies(sa_local_svc_timeout_ms);
> +			query->timeout = delay + jiffies;
> +			list_add_tail(&query->list, &ib_nl_request_list);
> +			/* Start the timeout if this is the only request */
> +			if (ib_nl_request_list.next == &query->list)
> +				queue_delayed_work(ib_nl_wq, &ib_nl_timed_work,
> +						delay);
> +			break;
> +		}
>  		ib_sa_disable_local_svc(query);
>  		/* Hold the lock to protect against query cancellation */
>  		if (ib_sa_query_cancelled(query))
> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>  
>  	send_buf = query->mad_buf;
>  
> +	/*
> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
> +	 * processing this query. If flag is not set, query can be accessed in
> +	 * another context while setting the flag and processing the query will
> +	 * eventually release it causing a possible use-after-free.
> +	 */
> +	if (unlikely(!ib_sa_nl_query_sent(query))) {

Can't there be a race here where you check the flag (it isn't set)
and before you call wait_event() the flag is set and wake_up() is called
which means you will wait here forever? or worse, a timeout will happen
the query will be freed and them some other query will call wake_up()
and we have again a use-after-free.

> +		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
> +		wait_event(wait_queue, ib_sa_nl_query_sent(query));

What if there are two queries sent to userspace, shouldn't you check and make sure
you got woken up by the right one setting the flag?

Other than that, the entire solution makes it very complicated to reason with (flags set/checked without locking etc)
maybe we should just revert and fix it the other way?

Mark 

> +		spin_lock_irqsave(&ib_nl_request_lock, flags);
> +	}
> +
>  	if (!ib_nl_is_good_resolve_resp(nlh)) {
>  		/* if the result is a failure, send out the packet via IB */
>  		ib_sa_disable_local_svc(query);
> 
