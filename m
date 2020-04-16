Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8E1ACF8E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgDPSX3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgDPSX1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Apr 2020 14:23:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4557CC061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:23:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l25so22399609qkk.3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iuykJESb51OsPtjzmrBfUka8e+6efZw5qO7PcI1hKug=;
        b=St+cWVlpkqzFYNzqKBaKUHWpaJx+LJdWkN5l2aHU2phVFEY8a9rm6xK4OzjUcqolih
         NbHKagg4L/aGico+RVxLcWRDcolrqdByPJ71iXxWZKGsxYBI0rBUZkLaNhAp26EGJUqF
         spWhWVOf0o+2lplbSQWiuZ+9DSS2w8KQ+oreCv8DVIv0nViHJELCw7IaCfgbYsW4tOvK
         cXG0HeTXAJfwvRuB9HrtgNDSrJQYvXYUpDOaapLYIrtWI5xW8Kbkhw1BygkRWPS9aNPT
         aFmWGyBstsV9fgenMbYnnimC1rCmRMWzPn7ep0QClMhBToxO2MTIDEcgFKFEg64tWNOS
         mtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iuykJESb51OsPtjzmrBfUka8e+6efZw5qO7PcI1hKug=;
        b=EjpkzNMSXADb5HjAj3LysF+mZ/dvW+Jh0YR21F/1vMUCE92vwwT7HGCpMzBTrnmFRg
         hz29DfYA9WDTnaPxDu6ckBt4aK5D4tIxfQCNs3XnznFw6Jpn7yt0nHr3REEASkd0tT8i
         yUkziAKZiK1pk3zwwWRsuKzeVXylL9EEMakC7hxG+XUNMO1qbsfpy50BtVJlSiovOU6R
         u09RAAFN3zirZ9U3vUWPGzg7HcSkPTC3YLA0H/E0ydIIqs7J5zNqCM9ebU4oWFHhZJ52
         WdRmbBQ6unI76fIOcyfg9FxJT4RI4i64C78Ex2cGdYAncetXsZI3P4FxEKyoCvkwQE8R
         dhxw==
X-Gm-Message-State: AGi0PuZSy/3cpTU6l4+yQ/bWvuU3pv7gAULVqoEcSEJrVpnDNf0SpEim
        gdLa+VG0W0OY1feDJKY1pY0qgw==
X-Google-Smtp-Source: APiQypIqWgHkrTV/ivEjx/yZ755hJrLBw3CFk9O6hnGetGrufPm33hul+yJ2dBrZWunSzz6hlKbGcw==
X-Received: by 2002:a37:6691:: with SMTP id a139mr22954410qkc.501.1587061406462;
        Thu, 16 Apr 2020 11:23:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v62sm6400944qkb.85.2020.04.16.11.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:23:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP9Ab-0006Nu-DB; Thu, 16 Apr 2020 15:23:25 -0300
Date:   Thu, 16 Apr 2020 15:23:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        ted.h.kim@oracle.com, william.taylor@oracle.com
Subject: Re: [PATCH for-rc] RDMA/cm: Do not send REJ when remote_id is unknown
Message-ID: <20200416182325.GY5100@ziepe.ca>
References: <20200414111720.1789168-1-haakon.bugge@oracle.com>
 <20200414204015.GA28572@ziepe.ca>
 <985C55AE-CD53-4C6D-8706-35D7F8170BB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <985C55AE-CD53-4C6D-8706-35D7F8170BB7@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 03:24:15PM +0200, Håkon Bugge wrote:
> 
> 
> > On 14 Apr 2020, at 22:40, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Tue, Apr 14, 2020 at 01:17:20PM +0200, Håkon Bugge wrote:
> >> In cm_destroy_id(), when the cm_id state is IB_CM_REQ_SENT or
> >> IB_CM_MRA_REQ_RCVD, an attempt is made to send a REJ with
> >> IB_CM_REJ_TIMEOUT as the reject reason.
> > 
> > Yes, this causes the remote to destroy the half completed connection,
> > for instance if the path is unidirectional.
> > 
> >> However, in said states, we have no remote_id. For the REQ_SENT case,
> >> we simply haven't received anything from our peer,
> > 
> > Which is correct, the spec covers this in Table 108 which describes
> > the remote communication ID as '0 if REJecting due to REP timeout and
> > no MRA was received'
> 
> Yes, the spec has the phrase for a REJ due toa timeout: "The
> recipient of a REJ message with this reason code must use this CA
> GUID to identify the sender, as it is possible that the Remote
> Communication ID in the REJ message may not be valid." [1]

It is a bit confusing, should we use the remote_id if not 0 after MRA?
Seems like a reasonable thing to do...


> > +static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 remote_id)
> > +{
> > +	struct cm_id_private *cm_id_priv = cm_acquire_req(local_id);
> > +
> > +	if (READ_ONCE(cm_id_priv->id.remote_id) != remote_id) {
> 
> Hmm, what if cm_id_priv is NULL?

Right, it should return NULL, woops
 
> The rest looks good to me, but I would like to backport it to the
> version I am familiar with and test it.

You might need a lot of backporting at this point :)

Jason
