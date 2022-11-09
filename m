Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983E62334D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKITPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 14:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKITPf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 14:15:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA415825
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 11:15:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJdXaNxN2DpaResdMWSx8SG4vj7G3tWXNYnxNZLPxtIqsf+bYvToKriXohOnmlS3dlNczXdFT4+lnQ7Vf9gvdY5qpHwvR6HJCz+1M85mjTgsn89sR0dL+8k/I0fc4RH+5/1jZ47XoENTR4IHzJShiUPM+f9oqTrJrMNr2AH6p6ucHVl0m0odet8PS6H1ik41QONaRdpE8ZZKR21QQSQM2+219LkZ7fjZ0xgw43SouXbDkj2AMIpDKcvwZQxPq51buZTAPEL82jqoMHiELS3tUD0FFHPa3/eIO6W5wMA0P4cgn6oJ8VCnn/e4g+AUeT0c0KCG9L+RfEd4OkhFCL8LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY7fWAYhKUhYH0QCOcP3Fnd10TJDJmR92dZCQrocReY=;
 b=GYU8Iu0JV+DlkOku5ranuD47zfMXBweAGigsHdX2yCOTvHduNbJGdpZtYUwyzrnbqoqerNw2rjCMVswFm7w9LIqAqQNE5xQg+JGb0zRy38XJmfa7hLHmxKE0gRej0+Z/540Y3/7pKLG/xfdJ4PkQaIWFI6VL6sEsxuTfqMYzKTaREayDmg69GWIyx48ZMajaB9d1xo5C3BpqtnmhjqnyhdFMbMYfhFqCCXoxT7KX5wWJad80il7ImMdEYekobNxC5GIUKEbFWjI8Ic9rJqSp27HMNejCRO9J5EX3WNtqxPnjtdQCzyDOM4IRO+pyXgrH/c40htQ/V3tGDA3122SAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY7fWAYhKUhYH0QCOcP3Fnd10TJDJmR92dZCQrocReY=;
 b=iScmbj6jUHwUvVYvytSi7gm30mHDkwTyypNwZqgEpCejOM1epeJ7DRvGJtt4sPdgxqp3al1pKkl4W7tk7Y2J4DK/wUq3c7+Fk1zfjQQkKr3EraRF1pCaNQZSasaH3fuIbccCIXRXrrc6xVBta8Hg/5/40U144L9yTKD0PITXPBwTv1Qp47k6NvHIUTWs9EY059L3utf3V9GSmDVqZIq70n+DtN3NbME6Tzm0+pq1/BHTC/elYlMQtQ/zPsjpSSvwvU6EgXELYwzYi7fbARscVPmaEpMvgh9yY4zkAS1MIx1IvGqVu196PpVTotC/QrKOrlUg3p0sbDcCmY5yTs1faA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 19:15:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 19:15:31 +0000
Date:   Wed, 9 Nov 2022 15:15:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/nldev: Use __nlmsg_put instead
 nlmsg_put
Message-ID: <Y2v8UsT015iiRuob@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
 <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: c1013ac7-54c4-44ea-1984-08dac286c500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paOoaNN0TxxLtqXx7eoLM6QS6T7ExPy3+/40zd8eKuKCZwgCuUcGtqQMyq/xmFGkQq+3IkR1H5YDGqo9KjsEZuI/YMsM4jBUl+VnRGEhjSxuw5UU3ANgzt7vl8WvTiyleyLgKzsFKKNfJEUEzmpPzD1OTacfzNsaBgZB71w1/7p26azPkgdzO2W2ZYC8K3nUdFf531KrDiliWQMimCYjKXE/vfRiAD6/CrkDvbVihyk9oCGJsMbNHuL6SlrPl9Le1dRZ9eehn3UOGsUDNBn56oSFeM+VFPudLfX/HaRMpxsWjrQjoyAxdSJdCS1g42iitGgcDb/p3Ys15/DIN20wO9EM8g0tLy+QIeFqFp4tW1W5NsSNd5oR//ql5id6EkQetE9HyVCL9K5joObD9u81Znsp7lkK47v/5VHLdohzXObpGPLiG4n2J3+blPwBCxoiZk1QpQAskKGaY7kH1sGCGsiot3pdbSE5y50uJxcF01loky2OyqdF/YCnG4e+OXO6If/3CT6ksC/eEV5kHVuKmd8/QpBt/qU96M93FQLtGI8lslEQ71tDC9cKnmA5eVhZTfMiK6es30C5WIP5BIHhTaHIokDfo/PDPqsNOG6xicPrUII1tXrWH3rz+izHNyi59Nn9lRrlBGkL2XT0RLBE5oNoXDQsqEQUNs93xQSZWEiBF/r+frGpvzVEvFlfWGHYgFgpqvzvRfamJUNe4C+Pbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(54906003)(38100700002)(6916009)(316002)(86362001)(83380400001)(2616005)(36756003)(2906002)(41300700001)(6486002)(66556008)(66476007)(66946007)(8676002)(4326008)(186003)(6512007)(6506007)(26005)(5660300002)(107886003)(478600001)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4tMEfpphDrrGf1eLwuON8W+Idj7Ei/RF+7tJjvrifAL2vG5ihRopQYQZ6oaV?=
 =?us-ascii?Q?Wa67lh+MggTAw/Ge9w0wQwF7o7fPc4vyujyAI+BFJUWtTP8keVlPIFjxxnhT?=
 =?us-ascii?Q?YWEkE/19fKQwYDUZbC9rUeZ/SWbEwvKsV/ROKbzPDW7G4/S86PpL1qz55NJH?=
 =?us-ascii?Q?UZRUnWZUCBGpQ3W3j1w0D318gz7NszkHkMZUN9iEtzXpgDRyek5bpa/hosqM?=
 =?us-ascii?Q?7n1PD0SsS9PfoNXwsgSUHrTewTH5A1GWuNr1OpKaiVigpZLlU5EPwF4ck9WU?=
 =?us-ascii?Q?Ppz/9lnjLbFh/HzfysLt+/yrE0p3lqU6TxkQPpeQn1P237WdbjCLrywdBiYW?=
 =?us-ascii?Q?rznKRHizruq+t7lUnCcqiiUFR/YX6MXeyoMljfGI1zvupKNC1WgHh5nlR6zd?=
 =?us-ascii?Q?83EYty0mzNACSlx+vxuU5KxxLlX5qVFm/DIXIM9Pt3/Zoz+8ZRw1bSj4K4an?=
 =?us-ascii?Q?lz2CuxFkKexhGsMME6TFmDD5yNGcXKNnU+AGDvXNCo44BxzZbZ4wry8cpdFt?=
 =?us-ascii?Q?gf3ksSBrU/c6CstmrlolKCxQje6PkwwlfNs3S2b9i05Qz7F3EgZE7BKAtGF5?=
 =?us-ascii?Q?3ieWwddjYHEEKhG2Z/FyVRri3CvO2XgyO4By5SvH/X4+NspDkPVSMX0k1aQX?=
 =?us-ascii?Q?Aw5G3YL8GyOzDY0H+yZTPH4JxyJbNmk6tgTnVOuZ6MmQrFEG4v108GDXrCJJ?=
 =?us-ascii?Q?3wWMJsVAtRGl0g7JDU1ghZco9spKLhzC6vMj1ewGNwg8ng4bXPX+mMLN3xFN?=
 =?us-ascii?Q?2MtTAmlRbeZfyk9v42RBjcMwfUN+OiFGbA/+n5lKINHu5fC+cuwkY/HumcSf?=
 =?us-ascii?Q?PAgvTjsOjw5T9VG1XOZdYYe+gFPxa5a7wjcKDMluSMfeYacTYDcTCFrEs5C+?=
 =?us-ascii?Q?tBbdJGWfE15lxN4cvMoXhg3agD3lBWDzjWp5jPcOIS4T2tv2IYMPZFSHWoTn?=
 =?us-ascii?Q?JexmzzF5pShRjRIikYxBvsgvvLFmFmr+cGUp8FN7Wuxeu7Sw1/+GTkCaLOru?=
 =?us-ascii?Q?9q3A7U92FyXw2TWWMuTYvhzRBI0MsK8paaSRUzgpur0rTaRBma1CxRjy49WT?=
 =?us-ascii?Q?vbIFVwJc8+WAZVSXxWXYEtAYE70eL+jHt49Rugrv49kCYMWxUxHDjftWpAwk?=
 =?us-ascii?Q?jVPZA0BAFQSzJcIkMgXs56UhnbqSk53zyhI8CBeyL5yfhTIkFPVJXI0QTYz1?=
 =?us-ascii?Q?d5EqGsMXXyJ8uUswsGOx3dRYNhLucc+QKJ5XdZfnCe+Eijhz0eSmfvuSZRAL?=
 =?us-ascii?Q?tixunY5iqPVNYMKW21krc1citivlQszvIzjauckP9lvKdQYq9uXIjYafoJy7?=
 =?us-ascii?Q?F+zfedwyTo2EsGgBvo8MiEXXE7C7XDYt7Ol9UnVZlCMHEwuZTtA5Z3gsFhzH?=
 =?us-ascii?Q?LF3x64VZEmcjKPXP1ByIKL8VwltOFNfvYqWmHfVhmLLAQEtEO2ZCpvDxsBS9?=
 =?us-ascii?Q?Dq187fPEi0jRVC3KZfJPVfByhLockBEApb0xDSe1qV4WRcsPQBTpz7bvHDN8?=
 =?us-ascii?Q?4gSglcDt4aIm5wc9sG5T63wANlUX+OxryN54ulZyCtM6HntL01X5tDTJgUjB?=
 =?us-ascii?Q?gxBWP+BNHyGqRXn9fB8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1013ac7-54c4-44ea-1984-08dac286c500
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 19:15:31.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIMo0lsvgMh2h/u2co+uub+hBdKzRVzPmEhTqaDgH1jJ7du2x0dZL1rhTkBP1WLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 07, 2022 at 10:51:33AM +0200, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Using nlmsg_put causes static analysis tools to many
> false positives of not checking the return value of nlmsg_put.
> 
> In all uses in nldev.c, payload parameter is 0 so NULL will never
> be returned. So let's use __nlmsg_put function to silence the
> warnings.

I'd rather just add useless checks for the errors than call a private
function like this. Or add some nlmsg_put_no_payload() that can't fail

Jason
