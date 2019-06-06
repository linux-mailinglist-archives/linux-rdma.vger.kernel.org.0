Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7E36C2E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfFFGY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 02:24:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGY5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 02:24:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x566JD5k112672
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 06:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uQlCezORECSSTw4Ct4/g5dKsnwDPb1l0dAHDaS4tIss=;
 b=tCA8XaolmBfNsgjuw1QDOgu7/x7tMedVpXMZOHtiFeeKtpEkWSTQVG0edzTPJonhFiMQ
 oylG8g5QXTAUS758jdDKOtqBR3WJnnBltNh8+b22AJPsTGT1o2tfoyr9tM0zZdqsJbL/
 6tZCHEMCHPZkOblxdVK1msGsw33GVaHOTmyBaxPrvewNHg3LhoIbNVrtf/9QZ2cb5vLc
 dmWeyQ/YQIIl7DB5V+RaEgyDRw9xvWn3oGIrzv3Fc291N3XnktOPSEEo3NuMPlebob+E
 1ikdmGPbNsTko62IzML6UhgwowzFMAS2XpKFTq5z27CdkV1OkOFiC3eZ7HBx334L/aC1 jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2suevdpqta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 06:24:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x566OZ3j117898
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 06:24:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2swnhak3ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 06:24:54 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x566OrHZ030911
        for <linux-rdma@vger.kernel.org>; Thu, 6 Jun 2019 06:24:53 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 23:24:53 -0700
Subject: Re: cma::addr_handler
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <3B7DEF8D-966E-4C75-9A6D-A55A7B323A4F@oracle.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <200e4a4b-1151-bcb1-08a8-55e21a393e9c@oracle.com>
Date:   Thu, 6 Jun 2019 14:24:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3B7DEF8D-966E-4C75-9A6D-A55A7B323A4F@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060047
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

How to handle "status = 0 && id_priv->cma_dev !=NULL"?

"if (!status && !id_priv->cma_dev)"  is false.

"} else if (status) {" is also false.

Zhu Yanjun

On 2019/6/5 21:40, Håkon Bugge wrote:
> Said function contains:
>
> 	if (!status && !id_priv->cma_dev) {
> 		status = cma_acquire_dev_by_src_ip(id_priv);
> 		if (status)
> 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
> 					     status);
> 	} else {
> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
> 	}
>
> Now, assuming status == 0 and the device already has been acquired (id_priv->cma_dev != NULL), we get the "error" message:
>
> RDMA CM: ADDR_ERROR: failed to resolve IP. status 0
>
> Probably not intentional.
>
> So, would we agree to have:
>
> 	} else if (status) {
> 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
> 	}
>
>
> instead?
>
>
> Thxs, Håkon
>
>
