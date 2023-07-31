Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88976A076
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGaSbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGaSbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:31:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419051988
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbzq+2W2t79wYep63VngK2NUezl8dddXNVfwZXldv5ty1wEO/fMKeSCwVdcFLJXmWZDgsvtSq9W2I+OTx91WJaY+j2GdvWPCfZzfcEXr7Sv7mhDcz3OfzVl84zfiZHRWbnxdACdzAW2N6Q+GJ39BfXPEPAh4kGpP7XZYGiNx55k/HzIk2YGJBDpi2I3hzJ/VyacrpWnXMm3Y/Dtc8bdIlV6jS70eX2X/zyyQ1nTHNRiICFMrj1LquQuFLyFZtVRwZCmgfnojubDvOp7LmwMudqb0kuyxI7GdzUgQS6yZoUPPfBsxhlTUcZ2AQm2yh9RrX5PdDVIPb3+8ahlOO906Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx6q7OBOuWXnd+xaZSJSj55vZdN9ACFUzrnG5zLrAtM=;
 b=ciVa7vxOzJiFofDaNu+SvcSsThsYPYvLgUM6t1YgZI20GyIRx/VWfclfLNM/GWZ80QqgUpZAXtxXMeKRguw8CU3DkaoRJN+gdOM/GXYNx+RM4oVKGfcBmxCio4Tvb32LMti4tvjwLWRpSfZ/UqeAwhGTx/bVUPMcVSKZfBbHldnVft5bGfkW2/+QPe9Gvr5kHd0WtwUHJIVhxS8Q4EcLzLl3eAmeVPN2Sp7V+qqTuSbO8USfk1V0LG7zAnGjgmaznfKxEyVr2tVMgSZD5/VkgOE5oApaVfaNimkzahI9MCSqY3IqYxrQM/GyjJGLE+G+IehdcbJ7dGS8Q4z7CrjIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx6q7OBOuWXnd+xaZSJSj55vZdN9ACFUzrnG5zLrAtM=;
 b=g5p9PvF8oD+qGfTz6Rl0B6eEzg/DSW7z3zHwhQkJfYkH3rgxWiwH/obSjJpviDNy74MUaNryz8l9QEHQW3V86Ro45hn9qCYsTpDB8vf4wZndMeJdGbMF9NKPoZcAUuZSy4rjZHbyHqCLLIrV2rav3VOpdzwkz67qTqtLH/2ZXcVENeZ+wlGZp+68ogls3Yu8X4Af1DhGz427gaJsVjpEXv6G2OLqBwHJrVF2GquG3amF2rVKiff4+VPTeKEghhTdBtXcK06jxu35Gd/YyPbjjRU8rL73LmMYSnmnJamX8MSz+5PUX4WgtKPrPwTu54skI3DISeyamAibdLOFPBdzkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:31:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:31:17 +0000
Date:   Mon, 31 Jul 2023 15:31:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Message-ID: <ZMf987OeXm7bdBDP@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-9-rpearsonhpe@gmail.com>
 <ZMf6XBIAD0A25csR@nvidia.com>
 <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7164a0-bd2f-49dd-15f2-08db91f4541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Op8D32saGURRN0XkLEgBqSy9jTftvXVEVER7WnsJs2OBOGF0FstrDIxFuoKnsSP7IDeX+uElbbdq/0rT/bAln11RNwdw8Mga0NE8w9iLdbpwebDxqjIzmb9xY/QzZrEefa8MEYfdZaNVuMUu6NXgHuQ4eh6MVOl7aRfnHrW9XE3TUIGFl1BlQke7nnypkxaDROmzwzgnhtK0RGLboX/Lu+LIfj2MOAN35oaGQ/KDVvYSImSVljcMx92xGCP4Gu+24g8mC+3LcaVmQKHHHxTMYncdvcjxKNWmzL+tSJZu+u+vmmxiopPU7AnOD1+tob1S9ThBoAYcz/3yqam5WBs5duiO3TtJYhkWDfD0PqQdV/EqQRJJCdXKIFoSedbMLzDizQ0+rQMSSOaQ72JyHSgk05jSKRFRoOYIwNBcvqvTJQY0sUhywe27f12z5QNCWdZxHAEz6e9tBrxJsrawxKKJySbCJjFrxwTKtw0Fl/+6liZtlRHHk10JdJcfHvt9LUGD5J8HPauvzm9/tAIr2HSQnxlX6hhKuWlbW4CM0eG/jvHwP3iUf+PGsNMQTUa7ICQ4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(53546011)(26005)(6506007)(186003)(478600001)(6486002)(66476007)(4326008)(6916009)(2616005)(6512007)(38100700002)(66556008)(66946007)(83380400001)(5660300002)(41300700001)(8936002)(316002)(2906002)(86362001)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDC80imL1DE0tJv0op11P+i+UYYlEo5wBd3V4JnuO4L4cPrVaV/X/H0CFqxk?=
 =?us-ascii?Q?H/6iVJJa6YoaRQF8AC48i2bxE7gTsBDYv9VT/iiU0WNOD1SfLEBUhSsAyJeH?=
 =?us-ascii?Q?dKsBX3r4qY/F3vRVkMWs6WZtIDWd4ELVInXup+5FHHh9kshP6wTTZ8RwrCIY?=
 =?us-ascii?Q?vceJadXzhIJELsG6qY3BcytpgVfrog/NFaFyzwQwgLDtKbMAAW91YusqjK36?=
 =?us-ascii?Q?2hlkxYoRq+mlW99FX7SpIeXeia6V6O5ndxQhZybeO94Ath1dWJFEvz+CBeiy?=
 =?us-ascii?Q?/orRPvVaP1QE0nhuvC9QlMjLH591iAMhWS6ijZf/bpRkZMX+k3IiqUPZd5ws?=
 =?us-ascii?Q?xzhftZNcPJ4TqXcz6MphdJizhmEJ+lLiFaL81qvhidzhOYvRfGNf+9TNC3sT?=
 =?us-ascii?Q?6eUdv5ARNlVW42EyXGC6SBV69lP0stL3dF8FbI+qLjvfQBct6a5B7P4o/OW+?=
 =?us-ascii?Q?4Xf0v4fcf9uwWraMtAZhld5VI6oGlW/6y5+sHTn6EkTp3MiynPz/mheVNNlP?=
 =?us-ascii?Q?OaosKeaGiqrqbUedLe5nbB1PJVJXTWGaqNlBnWCe04+BfHLdth43W4dcl3hC?=
 =?us-ascii?Q?9b0ZFOzDnewgYENHJRnyJ9Kz9+iapLJw2U4J2brHKgA3zZH195Kij+CoAYsL?=
 =?us-ascii?Q?irWG9M1DyMULcV5sGWEbug5EYB6cQ3lbn+kBQB0/0H0KgkjInNEn1zLigYo0?=
 =?us-ascii?Q?qffTkCzF3oFuOyO6ZLJU6u+tLO3OGUVbiOjVVWty8aGPGcXcHsCOlmeT9Mnj?=
 =?us-ascii?Q?zeIP63VGmYiJfPYC20mdfn6cRsw8ua5QAGl6pStShnNMeXvb30ZZsWb5o8iy?=
 =?us-ascii?Q?v3J58zD/C2DDvdfQBL2oJIBCmJnD1NvqLaFdV5eUg7Ct4rIyfQS7h3SRQFn5?=
 =?us-ascii?Q?UoirrBeXYhocFe3Kb0JvzbgjpjFqAM/Ijx41s1Nuw51Mychx7K5Kukxse4/Q?=
 =?us-ascii?Q?TaS8heevFdhEKOCc10cJuAu65QPNsUGMlvXO45PxsOTwECSaBwXMwkoCx+lG?=
 =?us-ascii?Q?s4S0UtgCS+luPu389B1JVXVrfrFlhLeSK0CnvZVOLQ/9nXtr6YWHtQZP+QbA?=
 =?us-ascii?Q?N5KocDCizhbEVfLYW+N/N2g8B9OTr9bMFpgzp0rtcXy7oMnNWjtdgVuQijZ5?=
 =?us-ascii?Q?H0i3tfmIdgNCEJzMGbfIjOPTtn2ck2/fBe0reSpxCZgVZGPJKxeRAOzOJjlS?=
 =?us-ascii?Q?1bNxQU6Ssl7Nhuu3Wdny8Uuu8syNiiRMyQEsO3QLlm9lfi1rMhl/Rzw+WA1J?=
 =?us-ascii?Q?zGgzPJFqOJYlXfINHoRZEf9sLVw9m7tQKf61PIidZNAbmrHmK8agNYFMXU6i?=
 =?us-ascii?Q?n2D132i2Jfbwq2XEFi3VDoQaJUxxIHe2TNCzcluiykYNUr57cH5lm9Em6ga3?=
 =?us-ascii?Q?8Mrr8t6EKuXYL7NRpdjqAachWH+MNZbfvuQjQA71fjtL1HHerzwKUg+PYmX/?=
 =?us-ascii?Q?lY+oE9CPO6055Q0B7ArXEEs/VBCrpu7V5srLkvO1OevDgOsLeMt4+nHEkTIi?=
 =?us-ascii?Q?zT0zGvAISeSXCQdqM3OeDPlaUiGv8ivz3RLXeaIelAc2sHS9OBwzHR+Mk1jF?=
 =?us-ascii?Q?KeU8Y+1q/X8n6W/tnHguizhvS3HgEK6DTyHZAHfN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7164a0-bd2f-49dd-15f2-08db91f4541a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:31:17.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjpXtwe8iOpJ65+gsCv49Wgeiy/RWsmUQnxvkjauBb+5vSTmTd/1VjUTA69ZfsYK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:23:59PM -0500, Bob Pearson wrote:
> On 7/31/23 13:15, Jason Gunthorpe wrote:
> > On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
> >> This patch gives a more detailed list of objects that are not
> >> freed in case of error before the module exits.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> index cb812bd969c6..3249c2741491 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
> >>  
> >>  void rxe_pool_cleanup(struct rxe_pool *pool)
> >>  {
> >> -	WARN_ON(!xa_empty(&pool->xa));
> >> +	unsigned long index;
> >> +	struct rxe_pool_elem *elem;
> >> +
> >> +	xa_lock(&pool->xa);
> >> +	xa_for_each(&pool->xa, index, elem) {
> >> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
> >> +				elem->index);
> >> +	}
> >> +	xa_unlock(&pool->xa);
> >> +
> >> +	xa_destroy(&pool->xa);
> >>  }
> > 
> > Is this why? Just count the number of unfinalized objects and report
> > if there is difference, don't mess up the xarray.
> > 
> > Jason
> This is why I made the last change but I really didn't like that there was no
> way to lookup the qp from its index since we were using a NULL xarray entry to
> indicate the state of the qp. Making it explicit, i.e. a variable in the struct
> seems much more straight forward. Not sure why you hated the last
> change.

Because if you don't call finalize abort has to be deterministic, and
abort can't be that if it someone else can access the poitner and, eg,
take a reference.

It breaks the entire model of how the memory ownership works during creation.

Jason
