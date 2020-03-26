Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C77194B9D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 23:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZWgz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 18:36:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44771 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZWgz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 18:36:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id j4so8857109qkc.11
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NormYpJ0WL2CED+488mTmDECM1nK7D4ZdOG55PqKthI=;
        b=PkPUIpZdJY6wSaOKhMDOEtebczZu4Zq6OuAJFko0Dx9GVtfQADpUcXimN3PDe3Hzye
         dgPV84DzdLsq11bsd4oHBFRLpxVxasMmrtiu2k5BIHbovdFpr7ewJx+LeAd5TalvkXax
         vgQTPpmQUB5M1a5vKFznMCr+v4GgVFkYYyBXHm8n7Hya4CRFIdgj5zmQOid4vP2KpdBO
         7L1hQcfF129LD7ixrNn3NBe/5gKajH69dfw9Gd1GLzL/2e6bulqEjE6882Wr9x5jYjR/
         zVkUR498WYJNLFzYCccNASj/IO/dorqtkhxq52TzkTCZlV3Iw/+pDIAxDHHQONO3m/ha
         Zhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NormYpJ0WL2CED+488mTmDECM1nK7D4ZdOG55PqKthI=;
        b=pgvLzXhtHPLmVWU4WZ01+y2cSO+LG0SpeJzt+PdaBzTNsUjt9qS79nD0duPW6BSZ6m
         KqsLIV2I4SBNNwQynf5mWsn6IsKG/MMS37OT0uWjUJjEIaoXuvTbtVnCUSKgPnl0UgmS
         8khrmDlGKyRQ/JBEp8eYsoOwN4bhdBAecon1DLR2JUaWwHTeiZ7sRWjg/f8WL/v2ARtZ
         E3v2WJnJY9PoV6XDVx7cBwszzjfsJ2KWVhbOrt5oUodRzmg56WHbuk1jNDtWWEyXpJqp
         1rjctp2rzXQUNN8VlcTcjgayre2MRApgiX/9qHd+uy8mJOrKgVlh1ul4ifv3ekGRYxaA
         7rAA==
X-Gm-Message-State: ANhLgQ3wGEGj/yNSO4H8AhMmEgdjJ6DPwXt0xHA8Jl3ST6DE9Rz5df+E
        LpPMGYAI55T1lWeldN5tFvfJLER46lbHyg==
X-Google-Smtp-Source: ADFU+vvlxsSdFFr7nLxH8lIXDgrYj8G3NGiQXaM0cMsSnurErLQ6dBYf6xeq+wJogmzJZxteNBJANg==
X-Received: by 2002:a37:e87:: with SMTP id 129mr11015532qko.340.1585262214038;
        Thu, 26 Mar 2020 15:36:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y132sm2421742qka.19.2020.03.26.15.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 15:36:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHb7N-0003a9-8Z; Thu, 26 Mar 2020 19:36:53 -0300
Date:   Thu, 26 Mar 2020 19:36:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH for-rc 1/2] IB/hfi1: Fix memory leaks in sysfs
 registration and unregistration
Message-ID: <20200326223653.GQ20941@ziepe.ca>
References: <20200326163619.21129.13002.stgit@awfm-01.aw.intel.com>
 <20200326163807.21129.27371.stgit@awfm-01.aw.intel.com>
 <20200326172541.GM20941@ziepe.ca>
 <MW3PR11MB466550446C9C322CAB52AAE7F4CF0@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200326194251.GO20941@ziepe.ca>
 <MW3PR11MB466518FEF749DC4DD1ABDC91F4CF0@MW3PR11MB4665.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB466518FEF749DC4DD1ABDC91F4CF0@MW3PR11MB4665.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 26, 2020 at 10:24:51PM +0000, Wan, Kaike wrote:

> > To see if there is an issue here delete the kobject_del and kobject_put
> > entirely to leave a dangling sysfs during registration and see if ib device
> > unregistration explodes.

> I tried a patch wherein the function hfi1_verbs_unregister_sysfs()
> is never called at all and when unloading the driver the ib device
> un-registration went through smoothly(no error, the
> /sys/class/infiniband/hfi1_0 directory gone). Only kmemleak
> complaints were observed.

Then perhaps there is nothing to worry about and the patches are fine

Jason
