Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA07B201F49
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Jun 2020 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgFTAnZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 20:43:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFTAnY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 20:43:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05K0YvUD133598;
        Sat, 20 Jun 2020 00:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Zm4HMhoS8Kg8i91BJJp7jpLN4Zdhc+Xt1j6881tEgRY=;
 b=r8Q8AOnV2/tnZPJ0X9ElaDuVS1EAjCp+uNG38yCwPNVG0BSGQbRcgAKBSwRkfMIx9mj6
 uAuvyjZs7XAz0yfjn3DEGnknhrhEyLMzzRmv6yh2/nDZccgfneUemeaaj1CszaL8006U
 LCidNp1RBdS5qx3MI8nEtdljik8lQqx2zC92fBISDhAyx8VSH2Og0I2DN5WNEmK05fGr
 CeOpsoH+ZVq8DFuLtV/9z6xbtIbUVEykUGCNj3wkXmN+1q10drxjk17E1m5h5c5Nhmz3
 5fDrP92akQJ3oHKANpRntdaxGQwVaITkjRd2GVK+CPwjYMWT+DJrQ4040f5ul/EXiSqI Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31qecm7rr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Jun 2020 00:43:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05K0SqYU058298;
        Sat, 20 Jun 2020 00:43:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31s7jq9hvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 00:43:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05K0hGTr003731;
        Sat, 20 Jun 2020 00:43:16 GMT
Received: from dhcp-10-159-227-251.vpn.oracle.com (/10.159.227.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Jun 2020 00:43:16 +0000
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
 <20200614064156.GB2132762@unreal>
 <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
 <20200617182410.GK6578@ziepe.ca>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <3770b85e-c684-f534-d6d5-84cf0874e485@oracle.com>
Date:   Fri, 19 Jun 2020 17:43:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200617182410.GK6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0 mlxscore=0
 mlxlogscore=844 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1015 adultscore=0 suspectscore=3 spamscore=0 lowpriorityscore=0
 mlxlogscore=862 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006200000
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Thanks for taking the time to review!

On 6/17/20 11:24 AM, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2020 at 10:56:53AM -0700, Divya Indi wrote:
>> The other option might be to use GFP_NOWAIT conditionally ie
>> (only use GFP_NOWAIT when GFP_ATOMIC is not specified in gfp_mask else
>> use GFP_ATOMIC). Eventual goal being to not have a blocking memory allocation.
> This is probably safest for now, unless you can audit all callers and
> see if they can switch to GFP_NOWAIT as well

At present the callers with GFP_ATOMIC appear to be ipoib. Might not be
feasible to change them all to GFP_NOWAIT. 

Will incorporate the review comments and send out v3 early next week.

Thanks,
Divya

>
> Jason
