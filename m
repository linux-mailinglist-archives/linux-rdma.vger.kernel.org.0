Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786BF39CC0A
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jun 2021 03:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFFBMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Jun 2021 21:12:02 -0400
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:53090 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230022AbhFFBMC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Jun 2021 21:12:02 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 17133100E7B43;
        Sun,  6 Jun 2021 01:10:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 03FE4C4178;
        Sun,  6 Jun 2021 01:10:11 +0000 (UTC)
Message-ID: <9e07e80d8aa464447323670fd810f455d53f76f3.camel@perches.com>
Subject: irdma: utils.c typos in irdma_cqp_gather_stats_gen1 ?
From:   Joe Perches <joe@perches.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 05 Jun 2021 18:10:10 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 03FE4C4178
X-Spam-Status: No, score=1.10
X-Stat-Signature: skjieu6c8if6fmcgcrgx6a1j5q95zjrb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Pv7iUn8+XZ8iroSvbZ5WUjQz4ljaBJp4=
X-HE-Tag: 1622941811-105777
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are some odd mismatches in field and access index.
These may be simple cut/paste typos.

Are these intentional?

ip4txfrag is set to the value from IP4RXFRAGS

915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1753)  gather_stats->ip4txfrag =
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1754)          rd64(dev->hw,
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1755)               dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4RXFRAGS]
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1756)               + stats_inst_offset_64);

ip4txfrag is set again a few lines later, so the case above is probably
a defect.

915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1769)  gather_stats->ip4txfrag =
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1770)          rd64(dev->hw,
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1771)               dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP4TXFRAGS]
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1772)               + stats_inst_offset_64);

And here ip6txfrag is set to the value of IP6RXFRAGS

915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1785)  gather_stats->ip6txfrags =
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1786)          rd64(dev->hw,
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1787)               dev->hw_stats_regs_64[IRDMA_HW_STAT_INDEX_IP6RXFRAGS]
915cc7ac0f8e2a (Mustafa Ismail 2021-06-02 15:51:34 -0500 1788)               + stats_inst_offset_64);


