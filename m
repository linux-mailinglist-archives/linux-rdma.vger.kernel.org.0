Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D161D1843
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 17:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgEMPAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389191AbgEMPAX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 11:00:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287E2C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 08:00:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so21012qts.9
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/gHhPk7GJKztNSGPOhSZp7Hv5EC8SrF1OhwpLwo69k=;
        b=RSQKszL0u/dHGOGWPede1vpnwO2+X7WuJ5XWW9mGDiXbVHso5JIM3+lMkAxswpaxzu
         nSMI52fPr8vgSoyrlLtiJRX22kPsaBPYN1WKvtOcwq0Y4lc1qAJckq5wsuTU9y3w6xCM
         q3PfXwQgZfJL0gAdmWLQn+oyF8xGD9qKukhg9eU0+ZebQVkXswyOKLGzTEGQosxlDj3q
         +UNYBEFgjbOLnxjjGiEoq3t+3GY9pjHV8cz6dokNda72iGYOzaj4j7UBMQ2XVJsqizVb
         /dy3FYIn4dHBffEHQiIqFnQxSpu6WpzfTbYJQK0emGe8H7QIeU2Qf7wLQMdFrGJMfFcE
         RceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/gHhPk7GJKztNSGPOhSZp7Hv5EC8SrF1OhwpLwo69k=;
        b=cU/4mmVUpCe4n74qA3FNsDm7EPOcgM5PjEG72ESra4m3ElhbRuglQjr9tUrX530eOo
         Uh62XC+1sKLysMZCf6H3WKu98fHgW03Ne/X1T0yJL2dOnUBSBpUYXAdhVAoY5AEVHR4z
         v4nSl5ACJPEKliR5SYul/+32JSQejhSVuYM3Vq30QtB3gYd+xQ43Mrp94/YBNkRzgdPv
         kj9e25HpHUW1v4aMVPPWNjgSfZLqBZObbdJ8UDuL6aRPJ2Q1paR77eykRac+v5RY2Pok
         1hVmyAEg4FR2frPD4sheIfwj6Wj9QpB0gYECVxheb62e3LOv5SZAmv7WX9mWps8rEXDC
         ja3g==
X-Gm-Message-State: AOAM533LWn2ISGFJNSYwY36lSZcPOi3iFVpnhyoG+LhmLF5ucwQSBbai
        9r/aTISaeyldUA9kY12XX5dLtw==
X-Google-Smtp-Source: ABdhPJyAxBvGslgC+XCNN5oHAdLdB9zOqQyKvE6KoBSgBejnRkDJzHQVfiE5WV4SijHUMuMBgZoe1Q==
X-Received: by 2002:ac8:714c:: with SMTP id h12mr2999879qtp.372.1589382022247;
        Wed, 13 May 2020 08:00:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c41sm16311260qta.96.2020.05.13.08.00.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 08:00:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYsrt-0002QR-28; Wed, 13 May 2020 12:00:21 -0300
Date:   Wed, 13 May 2020 12:00:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH 1/2] IB/sa: Resolving use-after-free in ib_nl_send_msg.
Message-ID: <20200513150021.GD29989@ziepe.ca>
References: <1588876487-5781-1-git-send-email-divya.indi@oracle.com>
 <1588876487-5781-2-git-send-email-divya.indi@oracle.com>
 <20200508000809.GM26002@ziepe.ca>
 <33fc99e2-e9fc-3c8c-e47f-41535f514c2d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fc99e2-e9fc-3c8c-e47f-41535f514c2d@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 02:26:30PM -0700, Divya Indi wrote:
> >> @@ -1123,6 +1156,18 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
> >>  
> >>  	send_buf = query->mad_buf;
> >>  
> >> +	/*
> >> +	 * Make sure the IB_SA_NL_QUERY_SENT flag is set before
> >> +	 * processing this query. If flag is not set, query can be accessed in
> >> +	 * another context while setting the flag and processing the query will
> >> +	 * eventually release it causing a possible use-after-free.
> >> +	 */
> > This comment doesn't really make sense, flags insige the memory being
> > freed inherently can't prevent use after free.
> 
> I can definitely re-phrase here to make things clearer. But, the idea here is
> in the unlikely/rare case where a response for a query comes in before the flag has been
> set in ib_nl_make_request, we want to wait for the flag to be sent before proceeding. 
> The response handler will eventually release the query so this wait avoids that if the flag has not been set
> else 
> 	"query->flags |= IB_SA_NL_QUERY_SENT;" 
> will be accessing a query which was freed due to the above mentioned race.
> 
> It is unlikely since getting a response => We have actually sent out the query to ibacm.
> 
> How about this -
> 
> "Getting a response is indicative of having sent out the query, but in an unlikely race when 
> the response comes in before setting IB_SA_NL_QUERY_SENT, we need to wait till the flag is set to
> avoid accessing a query that has been released."

It still makes no sense, a flag that is set before freeing the memory
is fundamentally useless to prevent races.

Jason
