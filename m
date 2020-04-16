Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794161AC213
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894765AbgDPNJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 09:09:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894692AbgDPNJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 09:09:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GD8Bhi030563;
        Thu, 16 Apr 2020 13:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JVRFfnFS+OgWj7u5UNa3ISrw5T9J6EGkJSXP5AV0oP4=;
 b=kKM3XCkJV1xc4zUZKFip7MGr/drhgl31vuH/o+h5t35tdgm/gCgIaCAWFMs2H5nJEfrf
 5Eq+H9EQuNAVqB7LKcUcqK5e37QC/1iIiYGsKKDA4NBfOnhoO+116xwjwIHU9UEFbLTT
 zY0z8Y425XQ4cJC2CpzsLuzafOBa49ie4JVWzzxmUixlNFQUHy9Vp/vtsOxHpL43RTQ+
 8Yz+lxUZ2q8bxADDxZslpeAsDjFJ8TrpKLcnlmOJry0MQZ2F8Gj9TI2E5l/Hc47IgJY/
 J3fKyBgIw7DoBWzJN2JMeO7gA3gI7v774Tp9xsqLVkToKEQoGIJsHsKf6S1IkS/o61iW xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn95s9mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:09:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GD7F8s117906;
        Thu, 16 Apr 2020 13:09:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30emen0dbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 13:09:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03GD8wWc001606;
        Thu, 16 Apr 2020 13:08:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 06:08:58 -0700
Date:   Thu, 16 Apr 2020 16:08:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        roland@purestorage.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200416130847.GP1163@kadam>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414183441.GA28870@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160093
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> The memcpy is still kind of silly right? What about this:
> 
> static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> {
> 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> 	int cpy_len;
> 
> 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> 	if (cpy_len >= len || cpy_len < 0) {

The kernel version of snprintf() doesn't and will never return
negatives.  It would cause a huge security headache if it started
returning negatives.

> 		pr_err("%s: No space in stats buff\n", __func__);
> 		return 0;
> 	}

regards,
dan carpenter

