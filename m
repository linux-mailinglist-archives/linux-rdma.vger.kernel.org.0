Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95A9CB8D7
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfJDLCb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 07:02:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38823 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJDLCb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 07:02:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so3687590pfe.5
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ku4z59GegrGG+Xfk9fGT7bfSHa3f5Py2+RMuhy3okDg=;
        b=KPrEoUteCeYCa10uT2hn7fB1zM8Hfdoe38fSBpEFWdSxAeLJh80LvNzJLajpVpIDoX
         /iX2Pc4h0WUlJw74gUqIYTXsd3aS3JpzDEJN4AKPyJDVadMhQMAhQX65rEm880pH42Hj
         RDUPDWYlR7XhQrV5eNna2MGYLWZNX2T+y7fgeQXzM+Dxz/CZMJ4zE6dLWnRlkuz6PIRJ
         3FMGaXriotJwSR+ciw2d7MTCGmzZXmNvIox5y5m5J6eI2pmx/Wl3u/ZnGWFP2CReGuxW
         Si5R7xoklkhvvPqrnyQPM5XFBJBvVrldWYSS1IGnZHK7+jErRzs6Bi8Pzy9UgL1Nwh7H
         RCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ku4z59GegrGG+Xfk9fGT7bfSHa3f5Py2+RMuhy3okDg=;
        b=NL0/6H/mi6rSsepHD52+9EFEhy+ie7T1pHvVy9ln67k8AQHnd9JXNTsVq2CBwahF7J
         WOMRIDbJx5OoA7Ey+w0K6Zq5pb716Bs8MfuJBuI9HYfhFbLblt7fafOO99lc2tCG8hol
         m2zHRbHtDztK5B+VL1iWapl/iDepYFXXwV+lcFhB9hF9gprcJJ77EYIcIEvf790/PHhq
         K0tkpFFrcsxz6ozMRJBmwDzXEC25LNjoyS9BPpnpDP437fzSkWy7Aic8pKBGUcc5/Rhb
         jtPmBJPZSRhidkUEkZZhQFX9tsCaVTcOWj8l8dsKJnELgomR1GJ/1Qusi/MljckfJiHv
         Pf2Q==
X-Gm-Message-State: APjAAAW09pZr7TOcUPYn7mPvIU+4Kn98i2N3Vp+VoAB5ckDYc+fRLQ6b
        sUzB4cbEot8Bn94pBSdu6kItgg==
X-Google-Smtp-Source: APXvYqx4/60BB+JFHczOGrzL1Al0rm+OY0a+A9pZLRnWECaGlOjJLRWXCmf7DRnwimAuKwz5dG/Qgw==
X-Received: by 2002:a65:5804:: with SMTP id g4mr14680236pgr.362.1570186948359;
        Fri, 04 Oct 2019 04:02:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id v8sm8911794pje.6.2019.10.04.04.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 04:02:26 -0700 (PDT)
Date:   Fri, 4 Oct 2019 04:02:24 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 02/11] lib/interval-tree: add an equivalent tree with
 [a,b) intervals
Message-ID: <20191004110224.GA253758@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-3-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:49PM -0700, Davidlohr Bueso wrote:
> +/*									      \
> + * Iterate over intervals intersecting [start;end)			      \
> + *									      \
> + * Note that a node's interval intersects [start;end) iff:		      \
> + *   Cond1: ITSTART(node) < end						      \
> + * and									      \
> + *   Cond2: start < ITEND(node)						      \
> + */									      \
> +									      \
> +static ITSTRUCT *							      \
> +ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE end)	      \
> +{									      \
> +	while (true) {							      \
> +		/*							      \
> +		 * Loop invariant: start <= node->ITSUBTREE		      \
Should be start < node->ITSUBTREE
> +		 * (Cond2 is satisfied by one of the subtree nodes)	      \
> +		 */							      \
> +		if (node->ITRB.rb_left) {				      \
> +			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
> +						  ITSTRUCT, ITRB);	      \
> +			if (start < left->ITSUBTREE) {			      \
> +				/*					      \
> +				 * Some nodes in left subtree satisfy Cond2.  \
> +				 * Iterate to find the leftmost such node N.  \
> +				 * If it also satisfies Cond1, that's the     \
> +				 * match we are looking for. Otherwise, there \
> +				 * is no matching interval as nodes to the    \
> +				 * right of N can't satisfy Cond1 either.     \
> +				 */					      \
> +				node = left;				      \
> +				continue;				      \
> +			}						      \
> +		}							      \
> +		if (ITSTART(node) < end) {		/* Cond1 */	      \
> +			if (start < ITEND(node))	/* Cond2 */	      \
> +				return node;	/* node is leftmost match */  \
> +			if (node->ITRB.rb_right) {			      \
> +				node = rb_entry(node->ITRB.rb_right,	      \
> +						ITSTRUCT, ITRB);	      \
> +				if (start <= node->ITSUBTREE)		      \
Should be start < node->ITSUBTREE
> +					continue;			      \
> +			}						      \
> +		}							      \
> +		return NULL;	/* No match */				      \
> +	}								      \
> +}									      \

Other than that, the change looks good to me.

This is something I might use, regardless of the status of converting
other current users.

The name "interval_tree_gen.h" makes it ambiguous wether gen stands
for "generic" or "generator". This may sounds like a criticism,
but it's not - I think it really stands for both :)

Reviewed-by: Michel Lespinasse <walken@google.com>

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
