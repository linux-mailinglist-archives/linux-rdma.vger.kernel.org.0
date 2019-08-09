Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD24287740
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406218AbfHIK35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 9 Aug 2019 06:29:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406167AbfHIK34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 06:29:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79ATZx8022305
        for <linux-rdma@vger.kernel.org>; Fri, 9 Aug 2019 06:29:53 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u945df2ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2019 06:29:53 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 9 Aug 2019 10:29:53 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 9 Aug 2019 10:29:48 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019080910294656-266502 ;
          Fri, 9 Aug 2019 10:29:46 +0000 
In-Reply-To: <20190808164638.GA7795@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
Date:   Fri, 9 Aug 2019 10:29:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190808164638.GA7795@chelsio.com>,<20190805172605.GA5549@chelsio.com>
 <8499b96a-48dd-1286-ea0f-e66be34afffa@talpey.com>
 <20190731103310.23199-1-krishna2@chelsio.com>
 <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
 <OF95C29EF7.244FC9E1-ON0025844A.003D049F-0025844A.003E229B@notes.na.collabserv.com>
 <518b1734-5d72-e32d-376b-0fec1cbce8f5@talpey.com>
 <OF7F439620.B43AE37C-ON00258450.00524237-00258450.0052DFDC@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 5309F939:D7FB77B5-00258451:002EE699;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 38263
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080910-1059-0000-0000-0000000706A9
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.262215
X-IBM-SpamModules-Versions: BY=3.00011574; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244270; UDB=6.00656447; IPR=6.01025753;
 MB=3.00028106; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 10:29:51
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-09 09:10:29 - 6.00010264
x-cbparentid: 19080910-1060-0000-0000-0000000F069F
Message-Id: <OF5309F939.D7FB77B5-ON00258451.002EE699-00258451.0039A86F@notes.na.collabserv.com>
Subject: RE: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA message
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 08/08/2019 06:47PM
>Cc: "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Potnuri
>Bharat Teja" <bharat@chelsio.com>, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>
>Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler tries
>to read beyond MPA message
>
>On Thursday, August 08/08/19, 2019 at 15:05:12 +0000, Bernard Metzler
>wrote:
>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>> 
>> >To: "Tom Talpey" <tom@talpey.com>, <BMT@zurich.ibm.com>
>> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >Date: 08/05/2019 07:26PM
>> >Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
>> ><linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
>> ><bharat@chelsio.com>, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>
>> >Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>tries
>> >to read beyond MPA message
>> >
>> >On Friday, August 08/02/19, 2019 at 18:17:37 +0530, Tom Talpey
>wrote:
>> >> On 8/2/2019 7:18 AM, Bernard Metzler wrote:
>> >> > -----"Tom Talpey" <tom@talpey.com> wrote: -----
>> >> > 
>> >> >> To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju
>> >Eraparaju"
>> >> >> <krishna2@chelsio.com>
>> >> >> From: "Tom Talpey" <tom@talpey.com>
>> >> >> Date: 08/01/2019 08:54PM
>> >> >> Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
>> >bharat@chelsio.com,
>> >> >> nirranjan@chelsio.com, krishn2@chelsio.com
>> >> >> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>> >tries
>> >> >> to read beyond MPA message
>> >> >>
>> >> >> On 8/1/2019 6:56 AM, Bernard Metzler wrote:
>> >> >>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>> >-----
>> >> >>>
>> >> >>>> To: jgg@ziepe.ca, bmt@zurich.ibm.com
>> >> >>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >> >>>> Date: 07/31/2019 12:34PM
>> >> >>>> Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >> >>>> nirranjan@chelsio.com, krishn2@chelsio.com, "Krishnamraju
>> >> >> Eraparaju"
>> >> >>>> <krishna2@chelsio.com>
>> >> >>>> Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply handler
>> >tries to
>> >> >>>> read beyond MPA message
>> >> >>>>
>> >> >>>> while processing MPA Reply, SIW driver is trying to read
>extra
>> >4
>> >> >>>> bytes
>> >> >>>> than what peer has advertised as private data length.
>> >> >>>>
>> >> >>>> If a FPDU data is received before even siw_recv_mpa_rr()
>> >completed
>> >> >>>> reading MPA reply, then ksock_recv() in siw_recv_mpa_rr()
>> >could
>> >> >> also
>> >> >>>> read FPDU, if "size" is larger than advertised MPA reply
>> >length.
>> >> >>>>
>> >> >>>> 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
>> >> >>>> 502 {
>> >> >>>>            .............
>> >> >>>> 572
>> >> >>>> 573         if (rcvd > to_rcv)
>> >> >>>> 574                 return -EPROTO;   <----- Failure here
>> >> >>>>
>> >> >>>> Looks like the intention here is to throw an ERROR if the
>> >received
>> >> >>>> data
>> >> >>>> is more than the total private data length advertised by
>the
>> >peer.
>> >> >>>> But
>> >> >>>> reading beyond MPA message causes siw_cm to generate
>> >> >>>> RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv
>buffer
>> >is
>> >> >>>> already
>> >> >>>> queued with FPDU messages.
>> >> >>>>
>> >> >>>> Hence, this function should only read upto private data
>> >length.
>> >> >>>>
>> >> >>>> Signed-off-by: Krishnamraju Eraparaju
><krishna2@chelsio.com>
>> >> >>>> ---
>> >> >>>> drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
>> >> >>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> >> >>>>
>> >> >>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> >> >>>> b/drivers/infiniband/sw/siw/siw_cm.c
>> >> >>>> index a7cde98e73e8..8dc8cea2566c 100644
>> >> >>>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>> >> >>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> >> >>>> @@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct
>> >siw_cep
>> >> >> *cep)
>> >> >>>> 	 * A private data buffer gets allocated if
>hdr->params.pd_len
>> >!=
>> >> >> 0.
>> >> >>>> 	 */
>> >> >>>> 	if (!cep->mpa.pdata) {
>> >> >>>> -		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> >> >>>> +		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
>> >> >>>> 		if (!cep->mpa.pdata)
>> >> >>>> 			return -ENOMEM;
>> >> >>>> 	}
>> >> >>>> 	rcvd = ksock_recv(
>> >> >>>> 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct
>> >mpa_rr),
>> >> >>>> -		to_rcv + 4, MSG_DONTWAIT);
>> >> >>>> +		to_rcv, MSG_DONTWAIT);
>> >> >>>>
>> >> >>>> 	if (rcvd < 0)
>> >> >>>> 		return rcvd;
>> >> >>>> -- 
>> >> >>>> 2.23.0.rc0
>> >> >>>>
>> >> >>>>
>> >> >>>
>> >> >>> The intention of this code is to make sure the
>> >> >>> peer does not violates the MPA handshake rules.
>> >> >>> The initiator MUST NOT send extra data after its
>> >> >>> MPA request and before receiving the MPA reply.
>> >> >>
>> >> >> I think this is true only for MPA v2. With MPA v1, the
>> >> >> initiator can begin sending immediately (before receiving
>> >> >> the MPA reply), because there is no actual negotiation at
>> >> >> the MPA layer.
>> >> >>
>> >> >> With MPA v2, the negotiation exchange is required because
>> >> >> the type of the following message is predicated by the
>> >> >> "Enhanced mode" a|b|c|d flags present in the first 32 bits
>> >> >> of the private data buffer.
>> >> >>
>> >> >> So, it seems to me that additional logic is needed here to
>> >> >> determine the MPA version, before sniffing additional octets
>> >> >>from the incoming stream?
>> >> >>
>> >> >> Tom.
>> >> >>
>> >> > 
>> >> > There still is the marker negotiation taking place.
>> >> > RFC 5044 says in section 7.1.2:
>> >> > 
>> >> > "Note: Since the receiver's ability to deal with Markers is
>> >> >   unknown until the Request and Reply Frames have been
>> >> >   received, sending FPDUs before this occurs is not possible."
>> >> > 
>> >> > This section further discusses the responder's behavior,
>> >> > where it MUST receive a first FPDU from the initiator
>> >> > before sending its first FPDU:
>> >> > 
>> >> > "4.  MPA Responder mode implementations MUST receive and
>validate
>> >at
>> >> >         least one FPDU before sending any FPDUs or Markers."
>> >> > 
>> >> > So it appears with MPA version 1, the current siw
>> >> > code is correct. The initiator is entering FPDU mode
>> >> > first, and only after receiving the MPA reply frame.
>> >> > Only after the initiator sent a first FPDU, the responder
>> >> > can start using the connection in FPDU mode.
>> >> > Because of this somehow broken connection establishment
>> >> > procedure (only the initiator can start sending data), a
>> >> > later MPA version makes this first FPDU exchange explicit
>> >> > and selectable (zero length READ/WRITE/Send).
>> >> 
>> >> Yeah, I guess so. Because nobody ever actually implemented
>markers,
>> >> I think that they may more or less passively ignore this. But
>> >you're
>> >> currect that it's invalid protocol behavior.
>> >> 
>> >> If your testing didn't uncover any issues with existing
>> >implementations
>> >> failing to connect with your strict checking, I'm ok with it.
>> >Tom & Bernard,
>> >Thanks for the insight on MPA negotiation.
>> >
>> >Could the below patch be considered as a proper fix?
>> >
>> >diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> >b/drivers/infiniband/sw/siw/siw_cm.c
>> >index 9ce8a1b925d2..0aec1b5212f9 100644
>> >--- a/drivers/infiniband/sw/siw/siw_cm.c
>> >+++ b/drivers/infiniband/sw/siw/siw_cm.c
>> >@@ -503,6 +503,7 @@ static int siw_recv_mpa_rr(struct siw_cep
>*cep)
>> >        struct socket *s = cep->sock;
>> >        u16 pd_len;
>> >        int rcvd, to_rcv;
>> >+       int extra_data_check = 4; /* 4Bytes, for MPA rules
>violation
>> >checking */
>> >
>> >        if (cep->mpa.bytes_rcvd < sizeof(struct mpa_rr)) {
>> >                rcvd = ksock_recv(s, (char *)hdr +
>> >cep->mpa.bytes_rcvd,
>> >@@ -553,23 +554,37 @@ static int siw_recv_mpa_rr(struct siw_cep
>*cep)
>> >                return -EPROTO;
>> >        }
>> >
>> >+       /*
>> >+        * Peer must not send any extra data other than MPA
>messages
>> >until MPA
>> >+        * negotiation is completed, an exception is MPA V2
>> >client-server Mode,
>> >+        * IE, in this mode the peer after sending MPA Reply can
>> >immediately
>> >+        * start sending data in RDMA mode.
>> >+        */
>> 
>> This is unfortunately not true. The responder NEVER sends
>> an FPDU without having seen an FPDU from the initiator.
>> I just checked RFC 6581 again. The RTR (ready-to-receive)
>> indication from the initiator is still needed, but now
>> provided by the protocol and not the application: w/o
>> 'enhanced MPA setup', the initiator sends the first
>> FPDU as an application message. With 'enhanced MPA setup',
>> the initiator protocol entity sends (w/o application
>> interaction) a zero length READ/WRITE/Send as a first FPDU,
>> as previously negotiated with the responder. Again: only
>> after the responder has seen the first FPDU, it can
>> start sending in FPDU mode.
>If I understand your statements correctly: in MPA v2 clint-server
>mode,
>the responder application should have some logic to wait(after
>ESTABLISH
>event) until the first FPDU message is received from the initiator?
>
>Thanks,
>Krishna.

The responder may either delay the established event
until it sees the first peer FPDU, or it delays sending
the first (now already posted) FPDU, until it sees the
first initiator FPDU. This, since (theoretically), the
responder does not know yet the result of CRC and
Marker negotiation. siw delays the established event,
which seems the more clear path to me.

This MPA handshake is cumbersome. siw is permissive
for violations of these rules to the extend, that the
responder shall not send back to back the first FPDU
with the MPA reply. If a (Chelsio ?) iWarp adapter
would send the first responder FPDU only after it
got TCP acked its MPA reply, the chances are high the
(siw) iWarp initiator has already transitioned to RTS
and it would accept that FPU, even if not having sent
it's first FPDU.

siw sticks to this rule to that extend, since all receive
processing is triggered by socket callbacks (from
sk->sk_data_ready()). As long as the QP is not
in RTS, all TCP bytestream processing is done by the
MPA protocol (code in siw_cm.c). If the QP reaches
RTS, RX processing is done bt the full iWarp
protocol (code in siw_qp_rx.c for RX).
Now, if the higher layer (application) protocol has
a semantic where the responder sends the first message,
we could end up in an infinite wait for that packet
at initiator application side.
This, since the complete first FPDU was already
received at the TCP socket, while the QP was not in
RTS. It will not trigger any additional sk->sk_data_ready()
and we are stuck with a FPDU in the socket rx buffer.

I implemented that 4 bytes extra data testing only to
keep the siw protocol state machine as simple as
possible (it is already unfortunately complex, if
you count the lines in siw_cm.c), while following
the protocol rules.

I suggest to correctly implement peer2peer mode and
delay the established event at the responder side until
it got the negotiated first zero length FPDU. Out
of the possible options, siw supports both zero length
WRITE and READ, but no SEND, since this would consume
an extra receive WQE.

As a last resort, I might consider extending the
siw state machine to handle those - non-complaint -
cases gracefully. But, that would result in different
code than just avoiding checking for peer protocol
violation.

Thanks,
Bernard.


>> 
>> Sorry for the confusion. But the current
>> siw code appears to be just correct.
>> 
>> Thanks
>> Bernard
>> 
>> 
>> 
>> >+       if ((__mpa_rr_revision(cep->mpa.hdr.params.bits) ==
>> >MPA_REVISION_2) &&
>> >+               (cep->state == SIW_EPSTATE_AWAIT_MPAREP)) {
>> >+               int mpa_p2p_mode = cep->mpa.v2_ctrl_req.ord &
>> >+                               (MPA_V2_RDMA_WRITE_RTR |
>> >MPA_V2_RDMA_READ_RTR);
>> >+               if (!mpa_p2p_mode)
>> >+                       extra_data_check = 0;
>> >+       }
>> >+
>> >        /*
>> >         * At this point, we must have hdr->params.pd_len != 0.
>> >         * A private data buffer gets allocated if
>hdr->params.pd_len
>> >!=
>> >         * 0.
>> >         */
>> >        if (!cep->mpa.pdata) {
>> >-               cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>> >+               cep->mpa.pdata = kmalloc(pd_len +
>extra_data_check,
>> >GFP_KERNEL);
>> >                if (!cep->mpa.pdata)
>> >                        return -ENOMEM;
>> >        }
>> >        rcvd = ksock_recv(
>> >                s, cep->mpa.pdata + cep->mpa.bytes_rcvd -
>> >sizeof(struct
>> >mpa_rr),
>> >-               to_rcv + 4, MSG_DONTWAIT);
>> >+               to_rcv + extra_data_check, MSG_DONTWAIT);
>> >
>> >        if (rcvd < 0)
>> >                return rcvd;
>> >
>> >-       if (rcvd > to_rcv)
>> >+       if (extra_data_check && (rcvd > to_rcv))
>> >                return -EPROTO;
>> >
>> >        cep->mpa.bytes_rcvd += rcvd;
>> >
>> >-Krishna.
>> >> 
>> >> Tom.
>> >> 
>> >> 
>> >> 
>> >> > 
>> >> > Bernard.
>> >> > 
>> >> >>
>> >> >>> So, for the MPA request case, this code is needed
>> >> >>> to check for protocol correctness.
>> >> >>> You are right for the MPA reply case - if we are
>> >> >>> _not_ in peer2peer mode, the peer can immediately
>> >> >>> start sending data in RDMA mode after its MPA Reply.
>> >> >>> So we shall add appropriate code to be more specific
>> >> >>> For an error, we are (1) processing an MPA Request,
>> >> >>> OR (2) processing an MPA Reply AND we are not expected
>> >> >>> to send an initial READ/WRITE/Send as negotiated with
>> >> >>> the peer (peer2peer mode MPA handshake).
>> >> >>>
>> >> >>> Just removing this check would make siw more permissive,
>> >> >>> but to a point where peer MPA protocol errors are
>> >> >>> tolerated. I am not in favor of that level of
>> >> >>> forgiveness.
>> >> >>>
>> >> >>> If possible, please provide an appropriate patch
>> >> >>> or (if it causes current issues with another peer
>> >> >>> iWarp implementation) just run in MPA peer2peer mode,
>> >> >>> where the current check is appropriate.
>> >> >>> Otherwise, I would provide an appropriate fix by Monday
>> >> >>> (I am still out of office this week).
>> >> >>>
>> >> >>>
>> >> >>> Many thanks and best regards,
>> >> >>> Bernard.
>> >> >>>
>> >> >>>
>> >> >>>
>> >> >>
>> >> >>
>> >> > 
>> >> > 
>> >> > 
>> >
>> >
>> 
>
>

