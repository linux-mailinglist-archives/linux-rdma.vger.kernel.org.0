Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6877D569A6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZMqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 08:46:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56422 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZMqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jun 2019 08:46:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QChcVh195809;
        Wed, 26 Jun 2019 12:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xzqKaYtluYGBAIZxtGOqTh2EVv098zwBS3ZufJ/+I7Y=;
 b=nw1jd00WR2jSgVSRE6SoMOWuvZJs3Lfom1nAnjnKyJx0rLCaR9f8l8Lroc428gOvS4oy
 IrFROwXjMrCNQvYrYO72XxyPMH3WGw33IKSOy34i6M1PdTQDAsjOxaTTv9AP6hNwwLwk
 iwrNZyjYOyAYVv98ZI5i8fZkTPeCpWyy32SV9jDYjYuxOM7JZAUawP6d9M7qnokde7xJ
 0ECC+iHPascBo653ds8YBsPYlCzfCCs29YXCXs0nOk3bND0osfv8l8iPfwcIUw/UivGd
 K1uvAn+bJ4Cava1sGhyd5/fYRvYXJ2JwsUqOWGavWSOjHvdkjQ7RNr8WTN3y4l3WfWIC SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brta5jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 12:46:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QCjUjd039420;
        Wed, 26 Jun 2019 12:46:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7ct8h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 12:46:51 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QCkoPt024652;
        Wed, 26 Jun 2019 12:46:50 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 05:46:49 -0700
Date:   Wed, 26 Jun 2019 15:46:39 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [RFC rdma-core] verbs: add ibv_export_to_fd man page
Message-ID: <20190626124637.GA3091@lap1>
References: <20190626083614.23688-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083614.23688-1-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260152
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 11:36:14AM +0300, Shamir Rabinovitch wrote:
> Add the ibv_export_to_fd man page.

This is RFC but still suggesting to give some words here.

Also, subject is incorrect since man page is for all functions involved in
the shared-obj mechanism, not only the export_to_fd.

> 
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  libibverbs/man/ibv_export_to_fd.3.md | 109 +++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 libibverbs/man/ibv_export_to_fd.3.md
> 
> diff --git a/libibverbs/man/ibv_export_to_fd.3.md b/libibverbs/man/ibv_export_to_fd.3.md
> new file mode 100644
> index 00000000..8e3f0fb2
> --- /dev/null
> +++ b/libibverbs/man/ibv_export_to_fd.3.md
> @@ -0,0 +1,109 @@
> +---
> +date: 2018-06-26
> +footer: libibverbs
> +header: "Libibverbs Programmer's Manual"
> +layout: page
> +license: 'Licensed under the OpenIB.org BSD license (FreeBSD Variant) - See COPYING.md'
> +section: 3
> +title: ibv_export_to_fd
> +tagline: Verbs
> +---
> +
> +# NAME
> +
> +**ibv_export_to_fd**, **ibv_import_pd**, **ibv_import_mr** - export & import ib hw objects.
> +
> +# SYNOPSIS
> +
> +```c
> +#include <infiniband/verbs.h>
> +
> +int ibv_export_to_fd(uint32_t fd,
> +                     uint32_t *new_handle,
> +                     struct ibv_context *context,
> +                     enum uverbs_default_objects type,
> +                     uint32_t handle);
> +
> +struct ibv_pd *ibv_import_pd(struct ibv_context *context,
> +                             uint32_t fd,
> +                             uint32_t handle);
> +
> +struct ibv_mr *ibv_import_mr(struct ibv_context *context,
> +                             uint32_t fd,
> +                             uint32_t handle);
> +
> +uint32_t ibv_context_to_fd(struct ibv_context *context);
> +
> +uint32_t ibv_pd_to_handle(struct ibv_pd *pd);
> +
> +uint32_t ibv_mr_to_handle(struct ibv_mr *mr);

Do you know if extra stuff besides this new file needs to be done so i can
do ex man ibv_context_to_fd and get this man page?

> +
> +```
> +
> +# DESCRIPTION
> +
> +**ibv_export_to_fd**() export ib hw object (pd, mr,...) from context to another context represented by the file descriptor fd. The destination context (file descriptor) can

s/export/exports
s/from context/from one context

> +then  be shared with other processes via unix socket SCM_RIGHTS. Once shared, the destination process can import the exported objects from the shared file descriptor to

s/then  be/then be
s/via unix socket SCM_RIGHTS/by passing it via unix socket SCM_RIGHTS

> +it's current context by using the equivalent ibv_import_x (e.g. ibv_import_pd) verb which return ib hw object. The destruction of the imported object is done  by  using
> +the ib hw object destroy verb (e.g. ibv_dealloc_pd).
> +
> +## To export object (e.g. pd), the below steps should be taken:
> +
> +1. Allocate new shared context (ibv_open_device).
> +2. Get the new context file descriptor (ibv_context_to_fd).
> +3. Get the ib hw object handle (e.g. ibv_pd_to_handle).
> +4. Export the ib hw object to the file descriptor (ibv_export_to_fd).
> +
> +**ibv_import_pd**(), **ibv_import_mr**() import pd/mr previously exported via export context.
> +
> +**ibv_context_to_fd**() returs the file descriptor of the given context.

s/returs/returns

> +
> +**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle from the given object.

s/from the/of a

> +
> +# ARGUMENTS
> +
> +**ibv_export_to_fd**()
> +
> +*fd* is the destination context's file descriptor.
> +
> +*new_handle* is the handle of the new object.
> +
> +*context* is the context to export the object from.
> +
> +*type* is the type of the object being exported (e.g. UVERBS_OBJECT_PD).
> +
> +*handle* is the handle of the object being exported.
> +
> +**ibv_import_pd**(), **ibv_import_mr**()
> +
> +*context* the context to import the ib hw object to.
> +
> +*fd* is the source context's file descriptor.
> +
> +*handle* the handle the the exported object in the export context as returned from *ibv_export_to_fd*().

s/the handle the the exported/is the handle of the exported

> +
> +**ibv_context_to_fd**()
> +
> +*context* context obtained from **ibv_open_device**() verb.

Missing 'is'? (just to be consist with your other variables description)

> +
> +**ibv_pd_to_handle**(), **ibv_mr_to_handle**()
> +
> +*pd*, *mr* obtained from **ibv_alloc_pd**(), **ibv_reg_mr**() verbs.
> +
> +# RETURN VALUE
> +
> +**ibv_export_to_fd**() returns 0 on success, or the value of errno on failure (which indicates the failure reason).
> +
> +**ibv_import_pd**(), **ibv_import_mr**() - returns a pointer to the imported ib hw object, or NULL if the request fails. 

Redundant '-' (to be consist.... -:))

> +
> +**ibv_context_to_fd**() returs the file descriptor of the given context.

s/returs/returns

> +
> +**ibv_pd_to_handle**(), **ibv_mr_to_handle**() returns the ib hw object handle from the given object

Missing '.' at EOL (to be cons....)

> +
> +# SEE ALSO
> +
> +**ibv_dealloc_pd**(3), **ibv_dereg_mr**(3)
> +
> +# AUTHORS
> +
> +Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> -- 
> 2.21.0
> 
