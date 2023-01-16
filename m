Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF61D66C21A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjAPOWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 09:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjAPOWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 09:22:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A9D36FE1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 06:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zci85GmAEPnR8fkPEkJO/o9DukRrYyDiywrd7PiwrMWjlOUG8hhrmvlq2aedRrxUvBnQu3wlxGjPdslKoj9kq4QRM6DMAf39Kje6HrAJB103B3/TbOuo8WrQ3tKPfhvdjwLMZKNQlYUjyOkaGb+Omp/0ST6Ked6uRqYRHNdZP+eb4hFaqq2PVWV2flQkBXBLIClWXTkGM2JtcM+28j3CqWD9vFz/Y5P3R2yOAR66E7AJX4A5Y40bnAliT0Vi7tsMl6xD2ILBgp1dtBgt0NsD2hc2rHgdI06VjGDpMN3gGYmXnbD5enPwPWNtaSfD1iXNj21NZaltp7qiely509shyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrShL4uoUDRqoMpfxwpo3Rc1CDaRFl4Zq9Yk3FhMvtQ=;
 b=SmtwJl04mTvasZ8/g4ifNNV0itRtMcToYn9S7kMQ0NACh9xYWSwJGrdMkPIrJHIApxsfF9UFfwAMi7c9lG3Tvu+5fb/QSgL9cTfnQ8k6PrU6GTU3dyXmFr4bks9U1imDHg+j9TnGg/hQWTqoChJkNR+IuttuvMuC3oly/4sy9g8J6Oif+4UDsPryQ9hGuDONDuC5np8Hx2Aw0IoVw2TOTgsLmWHJ4OauzhbLpbwMQ3VYDiKEdH/x69WsZD0CXq1ExA0f8ZvTyMaQJ29Akzx68q1G5y2WU7qLwsC8DypRDFmH0zT4q2AFBDF8dZVzXiKb7RnmRlP+GnqNHit2zFoRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrShL4uoUDRqoMpfxwpo3Rc1CDaRFl4Zq9Yk3FhMvtQ=;
 b=QFt5SxaDSNDLQexbU09vUNWXr9XEGVniHXViTsXFckt1v0jqwA7KLckiAc3u/qXruxZkIceiL8hACSQpFisV8LvOR7B9JtsGDNZM4CfQZE37NLmDv+1+bYUzA0u0j+IdSCpnotHA+zeSbo1/ULDsga0J35BNM50xYDgwnMWCPi2dEhzX/xo7wS07BXkAQ8BaTJKNCvwH3Rdf0yerFdDcSuE2wKiTPi2j12kQJBCfirLafu1WyA4OX4bA1mmg8HXJHmYxJIScEnIsK1GmWVPBxflN/1WmNWPgQXheRIW9rtfXH0fkuvhZmD4Lzc5qF6oDggxAb87VQnB7dr1J/RMeSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 14:07:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 14:07:27 +0000
Date:   Mon, 16 Jan 2023 10:07:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH for-next v2 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8VaHhnzKjKruK3E@nvidia.com>
References: <20230113002116.457324-5-rpearsonhpe@gmail.com>
 <202301131143.CmoyVcul-lkp@intel.com>
 <53e4292f-8fff-a250-69b5-95338a294b6d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e4292f-8fff-a250-69b5-95338a294b6d@gmail.com>
X-ClientProxiedBy: BL1PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3612ea5d-c2b1-4e32-9028-08daf7caffda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3diweECef6dY5GD3rHaO1qKvF9AZjLfyjUf93EWqVYGtcXUxXr37EKj+mic9o5vmruTlk+tupvi7TgyizzMPwcdzG+wLvguBxe1PMqWV2ygqFq4SCTchJk+2aTBR66SnE47HIFt3uR6WuvdvGegCAE2FyYb2+l5d903/lEXdrkRTOxDVw1N8Unv3IXlls3Ny016XcY2cP8JcttwuYbiDwFKZ8ZWh+OVcp5ZK6vv+5b0FABb5Ktjq/FhXt7FdgqhZcHJjFd+41+d3tGL5p/odUmh6YaibwH9Dz0xgg/281OWsDpm8SC3vWHaCu46Da2rLbN8pGoCFeAyw6gO+rU2FmEXP04vrbbZUFPFsix7riY/WjV5mTp9ata1dpriO2ko1X/Tq7MPcBtu1+kyuG5wh2sjTA0R7BVXBi6drnUC+i8xyxEk2HZwOPJBU1jUEoro+ofzD0/DUYCTQI6tVgyBq/yvVk0peIOMZIysH7kO6fE8RMana12NqqYQu56VG0Jo+yyJRA0tzPIqUbS2/yFu+AyGdB9rKz4ozTr/XkFXImmYfahLaH6+49haJOy2TwpBfft+H3TI00lWUq10GXO++lKK5v8HtNNDkQGoYOHJhkuWRKPxtYs5qA7eDI92V+IO8BT2X1rWokzcQKzsw5KWC/rfQv1Jg7k/hLSNWq0TVZ2v5fbkqlJfsWyprJ3AX4EwanSHzl4ZOwyX9RFCcD4xwwpN5y1JQaEFbvc/guQGqtLMr/xx5H79CbbaGckrnViQ8+zM3m84aC+/dyhOhaerXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(36756003)(86362001)(8936002)(6916009)(8676002)(66556008)(66946007)(66476007)(2906002)(5660300002)(4326008)(38100700002)(478600001)(6486002)(316002)(966005)(41300700001)(53546011)(6512007)(2616005)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3Qgur0+4+e0dzF32dlDLDadEmXvu24AF2iyobYB2RNH1dCgHLbmmG7A7yJr?=
 =?us-ascii?Q?h4pY9dR4FFGlCQmr46TvqXsold4MA521YWHJzIYJCpWS3dNdfvVz0FyD3s6N?=
 =?us-ascii?Q?GnFMOlm8Eb0b41bOQL5XeaQ5Gp53CJff3k2bWDwMG8wTkGKz8tBQOxnK4AQy?=
 =?us-ascii?Q?YVipe+xbfvN6v4UXiJF70NU4bP0xtfOHBgvS8A0NSK3fbfCI0orl+m4/Yzq5?=
 =?us-ascii?Q?TNwODKxWE017B/VATuDB+YNvvldvT56gWLlpK6F3YlXg7JwbXlFhtv5Lcslg?=
 =?us-ascii?Q?EnM2SV4VE1ylheKVEoAKlMJbJTiyoKp2ghHTuRNqeRLACTwdiDxdMcXe0jFa?=
 =?us-ascii?Q?b3uAxbSDN4oJwTRFHauQOdr0JEVwBs7gqqb5BIoHuMfZ+cEsu2DLbBmCJiU1?=
 =?us-ascii?Q?+tfaBFWJow1ej57MD7fE/mwWoNqllmfMLGvODy8ZpGNtk9LuVP0jDRqwHSZx?=
 =?us-ascii?Q?TATAEUcQT0/FVWgW0ZioFBQBs2BleHDMvOpw01BWHyXZstlJAnBjrXcWV8Or?=
 =?us-ascii?Q?/dhOJGXezE+FbLsnLeoKqMYkjmN6905GnaEpPm0/4lUtYgi9uwcaNJW3eqrC?=
 =?us-ascii?Q?ly/S3v1AE/2+ourM1Me6eJVXN4wiqsQyulYX1d4qdHKdaGYOM38ZFAhlWaRb?=
 =?us-ascii?Q?9iiH2K3Rai/4TzL1O+LABI8hS/VRu9kecji76XpJt0kFKUN05XsE76FJ01vw?=
 =?us-ascii?Q?SkspB5EVQXVmaGTo9gu3HumY2okOoQGSzjgXqwjA2E+/jyxMPZ4YFWiyeHT+?=
 =?us-ascii?Q?EyAjamWT/zZ0dKMuzp0oj7kzf9uibKtmjM/pWU3q/JL/wk8MP5eXMYGnqs0B?=
 =?us-ascii?Q?aOkQJmjHxaQOQlCYoj6obQRwz3Auz6EaNzze53iFMybaD7ZTNlYaO/+FZao1?=
 =?us-ascii?Q?aEc0CJYZAi2kz0ec6GtKvNGglI6Z+2V0Dro69meYrRwZwgvZotRulIODXURh?=
 =?us-ascii?Q?CgcKD0CMDUKAyYvz7YYA1WorrS+hQQb64GasXj2WDJbX9WrEonN4D8Z0F3+Z?=
 =?us-ascii?Q?WRNqgIzSZKWiyaYmaIlK9D7dvorstu+4zCIz+AZSj8BENfhIAFcQzRL67VKU?=
 =?us-ascii?Q?XG6m/pYdv+8NJ04lH4zkj7tHeWS9H+3Gab6FMEJi5W299+tQM9vcgu3VC/6R?=
 =?us-ascii?Q?TbYA3FKVvXbg2dn+wFBvncjpUH+hGkbSWmENM6ooIPyprDqKfMk0Ui5n5RwE?=
 =?us-ascii?Q?bRLHL8FDA/xlc7iH8SHUDDAFTfMoQtxteMEJAhIFjqACuUj5PqEBKAwLl8Jm?=
 =?us-ascii?Q?t1k0WEb2y079mtU1maPMY19IDMkZBADq3CPrQLcN3bz/hR6BoMzodFE9bErO?=
 =?us-ascii?Q?05XNhXl5zXN9hJhhthdzv1vzSjPd6HaBO7QP7RUPPuYtBZlLW4iqMcXBayaa?=
 =?us-ascii?Q?7b7V4OmCAFX8yNWIvlXAldLpJO049YJXJFZAclPk/oZCIvkDclG54n1hbwho?=
 =?us-ascii?Q?rmuXCN/yyK4S8hVSpcOBAHwkprt0oxufs4NPBZjr+6HvpkxTLy+RgOwWNNVE?=
 =?us-ascii?Q?GC3zt87BDf55OZviUO0Hiq2r62G3oYyKjIpWXOJKn5lDJWq64g++4HKlWUwg?=
 =?us-ascii?Q?c+owXYe9EZCI7A3Q1F0uRF45lWjDx/09C1PPe9qU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612ea5d-c2b1-4e32-9028-08daf7caffda
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 14:07:27.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SADeeh5mArM5p0M/ohEUNS9basyaSNBn/VeOHMB+KpazTLVx2j08fhtBDPnyqRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 03:26:25PM -0600, Bob Pearson wrote:
> On 1/12/23 21:43, kernel test robot wrote:
> > Hi Bob,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on bd99ede8ef2dc03e29a181b755ba4f78da2644e6]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bob-Pearson/RDMA-rxe-Cleanup-mr_check_range/20230113-082406
> > base:   bd99ede8ef2dc03e29a181b755ba4f78da2644e6
> > patch link:    https://lore.kernel.org/r/20230113002116.457324-5-rpearsonhpe%40gmail.com
> > patch subject: [PATCH for-next v2 4/6] RDMA-rxe: Isolate mr code from atomic_write_reply()
> > config: powerpc-allmodconfig
> > compiler: powerpc-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/c7e5c2723da0d6b13e37cbff63dad653e5c8801c
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Bob-Pearson/RDMA-rxe-Cleanup-mr_check_range/20230113-082406
> >         git checkout c7e5c2723da0d6b13e37cbff63dad653e5c8801c
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/infiniband/sw/rxe/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from <command-line>:
> >    drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_do_atomic_write':
> >>> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_870' declared with attribute error: Need native word sized stores/loads for atomicity.
> 
> Jason,
> 	Does this mean that powerpc doesn't support u64 as a native type? Perhaps this is
> 	why the Fujitsu folks used CONFIG_64BIT in the atomic write patch which seemed a
> 	little strange.

Yes and yes

Jason
